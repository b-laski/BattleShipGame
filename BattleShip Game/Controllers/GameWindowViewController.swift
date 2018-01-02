//
//  GameWindowViewController.swift
//  BattleShip Game
//
//  Created by Bartłomiej Łaski on 24.12.2017.
//  Copyright © 2017 Bartłomiej Łaski. All rights reserved.
//

import Cocoa

class GameWindowViewController: NSViewController {
    
    let fieldButton: NSButton = {
        var button: NSButton = NSButton(frame: NSRect(x: 10, y: 10, width: 30, height: 30))
        return button;
    }();


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
