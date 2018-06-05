//
//  ViewController.swift
//  Damas POC
//
//  Created by Saurabh on 6/2/18.
//  Copyright © 2018 Saurabh. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var usenameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if UserDefaults.standard.string(forKey: "username")! != nil {
            
            usenameTextField.text = UserDefaults.standard.string(forKey: "username")!
            
            passwordTextField.text = UserDefaults.standard.string(forKey: "password")!
            
        } else{
            
            print(UserDefaults.standard.string(forKey: "username")!)
        
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submit(_ sender: Any) {
        
        if (usenameTextField.text?.isEmpty)! {
            
            print("Enter UserName")
            
        } else if (passwordTextField.text?.isEmpty)!{
         
            print("Enter UserName")
            
        } else{
            
            UserDefaults.standard.setValue(usenameTextField.text, forKey: "username")
            UserDefaults.standard.setValue(passwordTextField.text, forKey: "password")
            
        }
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    

}

