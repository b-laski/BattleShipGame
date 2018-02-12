//
//  Point.swift
//  BattleShip Game
//
//  Created by Bartłomiej Łaski on 11.02.2018.
//  Copyright © 2018 Bartłomiej Łaski. All rights reserved.
//

class Point {
    var x: Int = 0;
    var y: Int = 0;
    var hited: Bool = false;
    
    func SetPoint(_ x: Int, _ y: Int) -> Void {
        self.x = x;
        self.y = y;
    }
    
    func Hited() -> Void {
        self.hited = true;
    }
    
    func Find(_ x: Int, _ y: Int) -> Bool {
        return true;
    }
}
