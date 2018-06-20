//
//  ViewController.swift
//  Damas POC
//
//  Created by Saurabh on 6/2/18.
//  Copyright © 2018 Saurabh. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController,UITextFieldDelegate {

    let URL_USER_LOGIN = "http://staging.2xlme.com/index.php/rest/V1/app/login"
    
    //the defaultvalues to store user data
    let defaultValues = UserDefaults.standard
    
    @IBOutlet weak var usenameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if UserDefaults.standard.string(forKey: "username") != nil {
            
            usenameTextField.text = UserDefaults.standard.string(forKey: "username")!
            
            passwordTextField.text = UserDefaults.standard.string(forKey: "password")!
            
        } else{
            print("username not saved")
//            print(UserDefaults.standard.string(forKey: "username")!)
        
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submit(_ sender: Any) {
        
        if (usenameTextField.text?.isEmpty)! {
            
            errorLabel.text = "Enter UserName"
            
        } else if (passwordTextField.text?.isEmpty)!{
         
            errorLabel.text = "Enter Password"
            
        } else{
            let headers: HTTPHeaders = [
                "Authorization": "Bearer 3djeq4d60x4fvgh0e2jwm6otikufbf5s",
                "content-type": "application/json"
            ]
            
            //getting the username and password
            let parameters: Parameters=[
                "email":"\(usenameTextField.text!)",
                "password":"\(passwordTextField.text!)"
            ]
            
            //making a post request
            Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters, encoding: JSONEncoding.default,headers: headers).responseJSON
                {
                    response in
                    //printing response
                    print(response)
                    
                    //getting the json value from the server
                    if let result = response.result.value {
                        
                        let jsonData = result as! NSDictionary
                        
                        print(jsonData["status"]!)
                        
                        if(!(jsonData.value(forKey: "status") as! Bool)) {
                           
                            self.errorLabel.text = jsonData["message"] as? String
                        
                        } else{
                            
                            self.errorLabel.text = jsonData["message"] as? String
                            
                            self.defaultValues.setValue(self.usenameTextField.text, forKey: "username")
                            
                            self.defaultValues.setValue(self.passwordTextField.text, forKey: "password")
                            
                            if let customerDetails = jsonData["customer_details"] as? NSDictionary {
                             
                                self.defaultValues.setValue(customerDetails, forKey: "customerDetails")
                                
                            }

                            //switching the screen
                            let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                            self.navigationController?.pushViewController(profileViewController, animated: true)
                            
                            self.dismiss(animated: false, completion: nil)
                            
                        }
                    
                    }
                    
            }
            
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

