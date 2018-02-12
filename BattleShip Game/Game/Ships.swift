//
//  Ships.swift
//  BattleShip Game
//
//  Created by Bartłomiej Łaski on 13.12.2017.
//  Copyright © 2017 Bartłomiej Łaski. All rights reserved.
//

class Ships {
    
    var fregate: Int;
    var destrojer: Int;
    var krazownik: Int;
    var niszczyciel: Int;
    
    init(){
        fregate = 6;
        destrojer = 4;
        krazownik = 3;
        niszczyciel = 2;
    }
    
    func restertCountOfShips(){
        fregate = 6;
        destrojer = 4;
        krazownik = 3;
        niszczyciel = 2;
    }
    
    func countShips() -> Int{
        return fregate + destrojer + krazownik + niszczyciel;
    }
    
    func checkShips() -> Bool{
        if(fregate == 0 && destrojer == 0 && krazownik == 0 && niszczyciel == 0){
            return true;
        }
        return false;
    }
}
