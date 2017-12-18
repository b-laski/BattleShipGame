//
//  Game.swift
//  BattleShip Game
//
//  Created by Bartłomiej Łaski on 10.12.2017.
//  Copyright © 2017 Bartłomiej Łaski. All rights reserved.
//

import Foundation

class Game {
    
    var BF: Battlefield;
    let player1: Player;
    let player2: Player;
    var orientation: Bool = true;
    var ships: Ships;
    var playerType: PlayerType = PlayerType.PlayerOne
    var kindOfShip : Ship = Ship.Fregata;
    var status: Status = Status.addingShip;
    
    init(Player1: Player, Player2: Player) {
        self.ships = Ships();
        self.BF = Battlefield(ships: ships);
        self.player1 = Player1;
        self.player2 = Player2;
        BF.generateBotField();
    }
    
    func getStatus() -> Status{
        return status;
    }
    
    func getKindOfShip() -> Ship {
        return kindOfShip;
    }
    
    func setKindOfShip(value: Ship) -> Void {
        kindOfShip = value;
    }

    func startGame() -> Bool{
        if(ships.checkShips()){
            status = Status.starting;
            return true;
        }
        return false;
    }
    
    func addShip(kolumna: Int, wiersz: Int) -> Bool{
        if(status == Status.addingShip){
            let result = BF.addShip(kolumna: kolumna, wiersz: wiersz, position: self.orientation, shipType: self.kindOfShip , player: .PlayerOne)
            return result
        }
        return false;
    }
    
    func ShotToField(kolumna: Int, wiersz: Int) -> Bool{
        if(BF.shootToShip(kolumna: kolumna, wiersz: wiersz, playerType: .PlayerOne)){
            return true;
        } else {
            return false;
        }
    }
    
    func BotHit(button: Int) -> Bool{
        let kolumna: Int = button % UserDefaults.standard.integer(forKey: "FieldSize");
        let wiersz: Int = button / UserDefaults.standard.integer(forKey: "FieldSize");
        if(BF.shootToShip(kolumna: kolumna, wiersz: wiersz, playerType: .PlayerTwo)){
            return true;
        }
        return false;
    }
}
