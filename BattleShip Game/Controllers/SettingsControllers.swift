//
//  SettingsControllers.swift
//  BattleShip Game
//
//  Created by Bartłomiej Łaski on 05.12.2017.
//  Copyright © 2017 Bartłomiej Łaski. All rights reserved.
//

import Cocoa

class SettingsControllers: NSViewController {

    @IBOutlet weak var FieldSize: NSTextField!
    let settings : UserDefaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        if(!isKeyPresentInUserDefaults(key: "FieldSize")){
            FieldSize.stringValue = "24"
            setFieldSize(value: 24)
        }
        else{
            FieldSize.stringValue = String(getFieldSize())
        }
    }
    
    //Setters&Getters
    func getFieldSize() -> Int{
        return settings.integer(forKey: "FieldSize")
    }
    
    func setFieldSize(value: Int) -> Void{
        settings.set(value, forKey: "FieldSize");
    }
    //End
    
    //Actions
    @IBAction func SaveSettings(_ sender: Any) {
        
        guard let fieldsize: Int = Int(FieldSize.stringValue) else {
            _ = Helper.dialogOKCancel(question: "Filesize is not a number", text: "Please fix it 🐷!", buttons: .OK)
            return
        }
        
        if(Helper.dialogOKCancel(question: "Save settings!", text: "Are you sure?", buttons: .YesNo)){
            setFieldSize(value: fieldsize)
            self.view.window?.close();
        }
        
    }
    @IBAction func CancelButton(_ sender: NSButton) {
        if(Helper.dialogOKCancel(question: "Do you want to close windows?", text: "", buttons: .YesNo)){
            self.view.window?.close();
        }
    }
    //End

    //Helpers

    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    //End
}
