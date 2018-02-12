//
//  GameWindowsController.swift
//  BattleShip Game
//
//  Created by Bartłomiej Łaski on 29.11.2017.
//  Copyright © 2017 Bartłomiej Łaski. All rights reserved.
//

import Cocoa

class GameWindowsController: NSViewController {
    
    var game: Game? = nil;
    var position: Bool = true;
    var player1Field: [NSButton] = [];
    var player2Field: [NSButton] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Game";
        prepareWindow()
        game = Game(Player1: Player(), Player2: Player());
    }
    
    func prepareWindow() -> Void{
        
        var wight: Int = 20;
        var height: Int = 20;
        
        for _ in 0...UserDefaults.standard.integer(forKey: "FieldSize"){
            wight = wight + 20
        }
        
        for _ in 0...UserDefaults.standard.integer(forKey: "FieldSize"){
            height = height + 20
        }
        
        wight = (wight*2);
        height = height + 150;
        
        do {
            if let scrn: NSScreen = NSScreen.main {
                let rect: NSRect = scrn.frame
                if(height > Int(rect.size.height) && wight > Int()){
                    throw NSError(domain: "Okno jest zbyt duże by je zmieścić!", code: 500, userInfo: nil)
                }
                
                self.view.frame.size.width = CGFloat(wight);
                self.view.frame.size.height = CGFloat(height);
            
                
                GenerateButtons(Count: UserDefaults.standard.integer(forKey: "FieldSize"), _x: 20, _y: Int(self.view.frame.size.height) - 40, field: Field.Player1)
                GenerateButtons(Count: UserDefaults.standard.integer(forKey: "FieldSize"), _x: (Int(self.view.frame.size.width) / 2) + 20, _y: Int(self.view.frame.size.height) - 40, field: Field.Player2);
                GenerateButtonToShipType(_x: 20, _y: 20)
                Helper.turnOnOffButtons(ArrayWithButton: player2Field, isON: false);
            }
        }
        catch {
            _ = Helper.dialogOKCancel(question: "Okno za duże!", text: "Prosze zmiejszyć jego rozmiar w ustawieniach.", buttons: .OK)
            self.dismissViewController(self);
        }

    }
    
    func GenerateButtons(Count: Int , _x: Int, _y: Int, field: Field) -> Void {
        var x: Int = _x;
        var y: Int = _y;
        var buttonID: Int = 0
        for _ in 0...Count-1{
            for _ in 0...Count-1{
                let button: NSButton = NSButton(frame: CGRect(x: x, y: y, width: 20, height: 20))
                button.title = "";
                (button.cell as! NSButtonCell).isBordered = true;
                (button.cell as! NSButtonCell).backgroundColor = NSColor.lightGray;
                button.tag = buttonID;
                button.action = #selector(buttonPressed)
                if(field == Field.Player1){
                    player1Field.append(button);
                } else {
                    player2Field.append(button);
                }
                self.view.addSubview(button);
                x = x + 20;
                buttonID = buttonID + 1;
            }
            x=_x;
            y = y - 20;
        }
    }
    
    func GenerateButtonToShipType(_x: Int, _y: Int) -> Void {
        var x: Int = _x;
        let y: Int = _y;
        for item in 0...4{
            switch item {
            case 0:
                let button: NSButton = NSButton(frame: CGRect(x: x, y: y, width: 80, height: 20))
                button.title = "Fregata";
                button.tag = 0;
                button.action = #selector(selectShipToAdd)
                self.view.addSubview(button);
                break
            case 1:
                let button: NSButton = NSButton(frame: CGRect(x: x, y: y, width: 80, height: 20))
                button.title = "Destroyer";
                button.tag = 1;
                button.action = #selector(selectShipToAdd)
                self.view.addSubview(button);
                break
            case 2:
                let button: NSButton = NSButton(frame: CGRect(x: x, y: y, width: 80, height: 20))
                button.title = "Krazownik";
                button.tag = 2;
                button.action = #selector(selectShipToAdd)
                self.view.addSubview(button);
                break
            case 3:
                let button: NSButton = NSButton(frame: CGRect(x: x, y: y, width: 80, height: 20))
                button.title = "BattleShip";
                button.tag = 3;
                button.action = #selector(selectShipToAdd)
                self.view.addSubview(button);
                break
            case 4:
                let button: NSButton = NSButton(frame: CGRect(x: x, y: y, width: 80, height: 20))
                button.title = "Horizontal";
                button.tag = 4;
                button.action = #selector(selectPosition)
                self.view.addSubview(button);
                break
            default:
                break
            }
            x = x + 80
        }
    }
    
    @objc func buttonPressed(button:NSButton) {
        let kolumna: Int = button.tag % UserDefaults.standard.integer(forKey: "FieldSize");
        let wiersz: Int = button.tag / UserDefaults.standard.integer(forKey: "FieldSize");
        
        //print("[Wiersz:\(wiersz): Kolumna:\(kolumna)]")
        //print("Button.Tag = \(button.tag)")
        
        if(game?.status == Status.addingShip){
            let flaga = game?.addShip(kolumna: kolumna, wiersz: wiersz)
            if(flaga == true){
                if(game?.getKindOfShip() == Ship.Fregata){
                    button.title = "F"
                }
                
                if (game?.getKindOfShip() == Ship.Destrojer){
                    for item in 0...1{
                        if(game?.orientation == true){
                            let tag = ((wiersz + item) * UserDefaults.standard.integer(forKey: "FieldSize")) + kolumna ;
                            Helper.setPositionOfShips(ArrayWithButton: player1Field, tag: tag , kindOfShip: "D")
                        } else {
                            Helper.setPositionOfShips(ArrayWithButton: player1Field, tag: button.tag + item , kindOfShip: "D")
                        }
                    }
                }
                
                if (game?.getKindOfShip() == Ship.Krazownik){
                    for item in 0...2{
                        if(game?.orientation == true){
                            let tag = ((wiersz + item) * UserDefaults.standard.integer(forKey: "FieldSize")) + kolumna ;
                            Helper.setPositionOfShips(ArrayWithButton: player1Field, tag: tag , kindOfShip: "K")
                        } else {
                            Helper.setPositionOfShips(ArrayWithButton: player1Field, tag: button.tag + item , kindOfShip: "K")
                        }
                    }
                }
                
                if (game?.getKindOfShip() == Ship.BS){
                    for item in 0...3{
                        if(game?.orientation == true){
                            let tag = ((wiersz + item) * UserDefaults.standard.integer(forKey: "FieldSize")) + kolumna ;
                            Helper.setPositionOfShips(ArrayWithButton: player1Field, tag: tag , kindOfShip: "B")
                        } else {
                            Helper.setPositionOfShips(ArrayWithButton: player1Field, tag: button.tag + item , kindOfShip: "B")
                        }
                    }
                }
            }
            if(game?.startGame() == true){
                Helper.turnOnOffButtons(ArrayWithButton: player1Field, isON: false);
                Helper.turnOnOffButtons(ArrayWithButton: player2Field, isON: true);
                game?.status = Status.started;
                return
            }
        }
        
        if(game?.status == Status.started){
            if(game?.ShotToField(kolumna: kolumna, wiersz: wiersz, playerType: .PlayerOne))!{
                Helper.setHitOnShip(ArrayWithButton: player2Field, tag: button.tag)
                game?.player2.hit();
                print("player2: \(String(describing: (game?.player2.live)!))!");
            } else {
                Helper.setMissOnShip(ArrayWithButton: player2Field, tag: button.tag)
            }
            
            
            let fakeTag = Helper.checkTag(ArrayWithButton: player1Field)
            let x: Int = fakeTag % UserDefaults.standard.integer(forKey: "FieldSize");
            let y: Int = fakeTag / UserDefaults.standard.integer(forKey: "FieldSize");
            
            //print("[Wiersz:\(y): Kolumna:\(x)]")
            if(game?.ShotToField(kolumna: x, wiersz: y, playerType: .PlayerTwo) == true){
                Helper.setHitOnShip(ArrayWithButton: player1Field, tag: fakeTag)
                game?.player1.hit();
                print("[Player1 Live]: \(String(describing: (game?.player1.live)!))!");
            } else {
                Helper.setMissOnShip(ArrayWithButton: player1Field, tag: fakeTag)
            }
            
        }
        
        
        if(game?.player1.isDead() == true ){
            game?.status = Status.end
            _ = Helper.dialogOKCancel(question: "Game is ended", text: "Player 2 won!", buttons: .OK)
            self.view.window?.close();
        } else if (game?.player2.isDead() == true){
            game?.status = Status.end
            _ = Helper.dialogOKCancel(question: "Game is ended", text: "Player 1 won!", buttons: .OK)
            self.view.window?.close();
        }
    }
    
    @objc func selectPosition(button: NSButton){
        if(game?.orientation == true){
            button.title = "Vertical";
            game?.orientation = false;
        } else {
            button.title = "Horizontal"
            game?.orientation = true;
        }
    }
    
    @objc func selectShipToAdd(button: NSButton){
        switch button.tag {
        case 0:
            game?.setKindOfShip(value: .Fregata)
            print("0")
            break;
        case 1:
            game?.setKindOfShip(value: .Destrojer)
            print("1")
            break
        case 2:
            game?.setKindOfShip(value: .Krazownik)
            print("2")
            break
        case 3:
            game?.setKindOfShip(value: .BS)
            print("3")
            break
        default:
            return
        }
    }
    
}
