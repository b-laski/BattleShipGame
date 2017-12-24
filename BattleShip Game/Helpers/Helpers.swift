//
//  Helpers.swift
//  BattleShip Game
//
//  Created by Bartłomiej Łaski on 10.12.2017.
//  Copyright © 2017 Bartłomiej Łaski. All rights reserved.
//

import Foundation
import Cocoa

class Helper {
    
    /**
     Enum pomagajacy generowac przyciski
     */
    enum Buttons{
        case OK
        case YesNo
    }
    
    /**
    Metoda odpowiedzialna za tworzenie alertboxow.
    */
    static func dialogOKCancel(question: String, text: String, buttons: Buttons) -> Bool {
        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = text
        alert.alertStyle = .warning
        
        switch buttons {
        case .OK:
            alert.addButton(withTitle: "OK")
        case .YesNo:
            alert.addButton(withTitle: "Yes")
            alert.addButton(withTitle: "No")
        }
        
        
        return alert.runModal() == .alertFirstButtonReturn
    }
    
    /**
     Skrypt wylaczajacy i wlaczajcy przyciski na danym polu.
     */
    static func turnOnOffButtons(ArrayWithButton: [NSButton], isON: Bool) -> Void {
            if(isON == false){
                for item in 0...ArrayWithButton.count - 1 {
                    ArrayWithButton[item].isEnabled = false;
                }
            } else {
                for item in 0...ArrayWithButton.count - 1 {
                ArrayWithButton[item].isEnabled = true;
            }
        }
    }
    
    static func checkTag(ArrayWithButton: [NSButton]) -> Int{
        while true {
            let FakeTag = Int(arc4random_uniform(UInt32(ArrayWithButton.count)))
            
            if((ArrayWithButton[FakeTag].cell as! NSButtonCell).backgroundColor != NSColor.darkGray && ArrayWithButton[FakeTag].title != String(format: "%C", 0x274c)){
                return FakeTag;
            }
        }
    }
    
    static func setPositionOfShips(ArrayWithButton: [NSButton], tag: Int, kindOfShip: String) -> Void {
        ArrayWithButton[tag].title = kindOfShip;
    }
    
    static func setHitOnShip(ArrayWithButton: [NSButton], tag: Int) -> Void {
        ArrayWithButton[tag].title = String(format: "%C", 0x274c);
        ArrayWithButton[tag].isEnabled = false;
    }
    
    static func setMissOnShip(ArrayWithButton: [NSButton], tag: Int) -> Void {
        //ArrayWithButton[tag].title = String(describing: UnicodeScalar("0x274c"));
        (ArrayWithButton[tag].cell as! NSButtonCell).backgroundColor = NSColor.darkGray;
        ArrayWithButton[tag].isEnabled = false;
    }
}
