//
//  Player.swift
//  BattleShip Game
//
//  Created by Bartłomiej Łaski on 10.12.2017.
//  Copyright © 2017 Bartłomiej Łaski. All rights reserved.
//

import Foundation

class Player {
    
    var live: Int;
    
    init() {
        live = 31;
    }
    
    func isLive() -> Bool {
        if(live <= 0){
            return true
        }
        return false;
    }
    
    func hit(){
        live = live - 1;
    }
}
