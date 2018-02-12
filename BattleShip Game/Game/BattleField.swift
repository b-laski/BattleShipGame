//
//  BattleField.swift
//  BattleShip Game
//
//  Created by Bartłomiej Łaski on 10.12.2017.
//  Copyright © 2017 Bartłomiej Łaski. All rights reserved.
//

import Foundation

class Battlefield {

    var player1BattleField: [[Bool]] = [];
    var player2BattleField: [[Bool]] = [];
    var listOfShips: [Shipp] = [];
    var ships: Ships;
    
    init(ships: Ships) {
        player1BattleField = Array(repeating: Array(repeating: false, count: Int(UserDefaults.standard.integer(forKey: "FieldSize"))), count: Int(UserDefaults.standard.integer(forKey: "FieldSize")))
        player2BattleField = Array(repeating: Array(repeating: false, count: Int(UserDefaults.standard.integer(forKey: "FieldSize"))), count: Int(UserDefaults.standard.integer(forKey: "FieldSize")))
        self.ships = ships;
    }
    
    func generateBotField(){
        var i: Int = 0;
        let fregate = ships.fregate
        while(i < fregate){
            let kolumna: Int = Int(arc4random_uniform(UInt32(UserDefaults.standard.integer(forKey: "FieldSize"))));
            let wiersz: Int = Int(arc4random_uniform(UInt32(UserDefaults.standard.integer(forKey: "FieldSize"))));
            let randomOrientation: Bool = Int(arc4random_uniform(UInt32(1))) == 0 ? true : false;
            if(addShip(kolumna: kolumna, wiersz: wiersz, position: randomOrientation, shipType: .Fregata, player: .PlayerTwo)){
                i += 1;
            }
            //print("\(i). Fregata dodana!")
        }
        i=0;
        let destrojer = ships.destrojer
        while(i < destrojer){
            let kolumna: Int = Int(arc4random_uniform(UInt32(UserDefaults.standard.integer(forKey: "FieldSize"))));
            let wiersz: Int = Int(arc4random_uniform(UInt32(UserDefaults.standard.integer(forKey: "FieldSize"))));
            let randomOrientation: Bool = Int(arc4random_uniform(UInt32(1))) == 0 ? true : false;
            if(addShip(kolumna: kolumna, wiersz: wiersz, position: randomOrientation, shipType: .Destrojer, player: .PlayerTwo)){
                i += 1;
            }
            //print("\(i). Destrojer dodany!")
        }
        i=0;
        let krazownik = ships.krazownik
        while(i < krazownik){
            let kolumna: Int = Int(arc4random_uniform(UInt32(UserDefaults.standard.integer(forKey: "FieldSize"))));
            let wiersz: Int = Int(arc4random_uniform(UInt32(UserDefaults.standard.integer(forKey: "FieldSize"))));
            let randomOrientation: Bool = Int(arc4random_uniform(UInt32(1))) == 0 ? true : false;
            if(addShip(kolumna: kolumna, wiersz: wiersz, position: randomOrientation, shipType: .Krazownik, player: .PlayerTwo) == false){
                i += 1;
            }
            //print("\(i). Krazownik dodany!")
        }
        i=0;
        let niszczyciel = ships.niszczyciel;
        while(i < niszczyciel){
            let kolumna: Int = Int(arc4random_uniform(UInt32(UserDefaults.standard.integer(forKey: "FieldSize"))));
            let wiersz: Int = Int(arc4random_uniform(UInt32(UserDefaults.standard.integer(forKey: "FieldSize"))));
            let randomOrientation: Bool = Int(arc4random_uniform(UInt32(2))) == 0 ? true : false;
            if(addShip(kolumna: kolumna, wiersz: wiersz, position: randomOrientation, shipType: .BS, player: .PlayerTwo)){
                i += 1;
            }
            //print("\(i). Niszczyciel dodany!")
        }
        ships.restertCountOfShips();
    }
    
    private func checkPlaces(kolumna: Int, wiersz: Int, wielkosc_statku: Int, position: Bool, bf: [[Bool]]) -> Bool {
        for item in 0...wielkosc_statku{
            if(position == false){
                if(kolumna + item > UserDefaults.standard.integer(forKey: "FieldSize") - 1){
                    return false;
                }
                else if(bf[kolumna + item][wiersz] == true){
                    return false;
                }
            } else {
                if(wiersz + item > UserDefaults.standard.integer(forKey: "FieldSize") - 1){
                    return false;
                }
                else if(bf[kolumna][wiersz + item] == true){
                    return false;
                }
            }
        }
        return true;
    }
    
    func setArray(player: PlayerType) -> [[Bool]]{
        if(player == PlayerType.PlayerOne){
            return self.player1BattleField;
        }
        return self.player2BattleField;
    }
    
    func updateField(player: PlayerType, kolumna: Int, wiersz: Int){
        if(player == PlayerType.PlayerOne){
            player1BattleField[kolumna][wiersz] = true;
        } else {
            player2BattleField[kolumna][wiersz] = true;
        }
    }
    
    func addShip(kolumna: Int, wiersz: Int, position: Bool, shipType: Ship, player: PlayerType) -> Bool {
        var battlefield = setArray(player: player)
        switch shipType {
        case Ship.Fregata:
            if(ships.fregate != 0 && battlefield[kolumna][wiersz] == false){
                let fregate: Fregate = Fregate()
                fregate.AddPoint(x: kolumna, y: wiersz)
                updateField(player: player, kolumna: kolumna, wiersz: wiersz);
                ships.fregate -= 1;
                listOfShips.append(fregate)
                return true;
            }
            return false;
        case Ship.Destrojer:
            if(ships.destrojer != 0 && battlefield[kolumna][wiersz] == false){
                let flaga = checkPlaces(kolumna: kolumna, wiersz: wiersz, wielkosc_statku: 1, position: position, bf: battlefield)
                let destro: Destrojer = Destrojer()
                for item in 0...1{
                    if(position == false && flaga) {
                        destro.AddPoint(x: kolumna + item, y: wiersz)
                        updateField(player: player, kolumna: kolumna + item, wiersz: wiersz);
                    } else if (position == true && flaga) {
                        destro.AddPoint(x: kolumna, y: wiersz + item)
                        updateField(player: player, kolumna: kolumna, wiersz: wiersz + item);
                    } else {
                        return false;
                    }
                }
                listOfShips.append(destro);
                ships.destrojer -= 1;
                return true;
            }
            return false;
        case Ship.Krazownik:
            if(ships.krazownik != 0 && battlefield[kolumna][wiersz] == false){
                let flaga = checkPlaces(kolumna: kolumna, wiersz: wiersz, wielkosc_statku: 2, position: position, bf: battlefield)
                let krazo: Krazownik = Krazownik()
                for item in 0...2{
                    if(position == false && flaga) {
                        krazo.AddPoint(x: kolumna + item, y: wiersz)
                        updateField(player: player, kolumna: kolumna + item, wiersz: wiersz);
                    } else if (position == true && flaga) {
                        krazo.AddPoint(x: kolumna, y: wiersz + item)
                        updateField(player: player, kolumna: kolumna, wiersz: wiersz + item);
                    } else {
                        return false;
                    }
                }
                listOfShips.append(krazo)
                ships.krazownik -= 1;
                return true;
            }
            return false;
        case Ship.BS:
            if(ships.niszczyciel != 0 && battlefield[kolumna][wiersz] == false){
                let flaga = checkPlaces(kolumna: kolumna, wiersz: wiersz, wielkosc_statku: 3, position: position, bf: battlefield)
                let bs: BS = BS()
                for item in 0...3{
                    if(position == false && flaga) {
                        bs.AddPoint(x: kolumna + item, y: wiersz)
                        updateField(player: player, kolumna: kolumna + item, wiersz: wiersz);
                    } else if (position == true && flaga) {
                        bs.AddPoint(x: kolumna, y: wiersz + item)
                        updateField(player: player, kolumna: kolumna, wiersz: wiersz + item);
                    } else {
                        return false;
                    }
                }
                listOfShips.append(bs)
                ships.niszczyciel -= 1;
                return true;
            }
            return false;
        }
    }
    
    func shootToShip(kolumna: Int, wiersz: Int, playerType: PlayerType) -> Bool{
        if(playerType == PlayerType.PlayerOne){
            if(self.player2BattleField[kolumna][wiersz] == true){
                for item in listOfShips{
                    let _: Bool = item.Find(x: kolumna, y: wiersz)
                }
                return true
            }
            return false;
        } else {
            if(self.player1BattleField[kolumna][wiersz] == true){
                return true
            }
            return false;
        }
    }
}
