//
//  Shipp.swift
//  BattleShip Game
//
//  Created by Bartłomiej Łaski on 11.02.2018.
//  Copyright © 2018 Bartłomiej Łaski. All rights reserved.
//

protocol Shipp {
    var Points: [Point] {get set}
    
    func AddPoint(x: Int, y:Int)
    func Hited(x: Int, y:Int)
    func Find(x: Int, y:Int) -> Bool
}

class Fregate: Shipp {
    var Points: [Point] = []
    
    func AddPoint(x: Int, y: Int) {
        let point: Point = Point()
        point.SetPoint(x,y)
        Points.append(point)
    }
    
    func Hited(x: Int, y: Int) {
    }
    
    func Find(x: Int, y: Int) -> Bool{
        for item in Points{
            if(item.x == x && item.y == y){
                return true
            }
        }
        return false
    }
}

class Destrojer: Shipp {
    var Points: [Point] = []
    
    func AddPoint(x: Int, y: Int) {
        let point: Point = Point()
        point.SetPoint(x,y)
        Points.append(point)
    }
    
    func Hited(x: Int, y: Int) {
        
    }
    
    func Find(x: Int, y: Int) -> Bool{
        for item in Points{
            if(item.x == x && item.y == y){
                return true
            }
        }
        return false
    }
}

class Krazownik: Shipp {
    var Points: [Point] = []
    
    func AddPoint(x: Int, y: Int) {
        let point: Point = Point()
        point.SetPoint(x,y)
        Points.append(point)
    }
    
    func Hited(x: Int, y: Int) {
        
    }
    
    func Find(x: Int, y: Int) -> Bool{
        for item in Points{
            if(item.x == x && item.y == y){
                return true
            }
        }
        return false
    }
}

class BS: Shipp {
    var Points: [Point] = []
    
    func AddPoint(x: Int, y: Int) {
        let point: Point = Point()
        point.SetPoint(x,y)
        Points.append(point)
    }
    
    func Hited(x: Int, y: Int) {
    }
    
    func Find(x: Int, y: Int) -> Bool{
        for item in Points{
            if(item.x == x && item.y == y){
                return true
            }
        }
        return false
    }
}
