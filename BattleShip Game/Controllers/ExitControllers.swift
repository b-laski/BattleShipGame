//
//  ExitControllers.swift
//  BattleShip Game
//
//  Created by Bartłomiej Łaski on 29.11.2017.
//  Copyright © 2017 Bartłomiej Łaski. All rights reserved.
//

import Cocoa

class ExitControllers: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func CancelButton(_ sender: Any) {
        dismissViewController(self);
    }
    
    @IBAction func ExitButton(_ sender: Any) {
        exit(0);
    }
}
