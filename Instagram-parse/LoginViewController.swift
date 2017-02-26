//
//  LoginViewController.swift
//  Instagram-parse
//
//  Created by Derrick Wong on 2/24/17.
//  Copyright © 2017 Derrick Wong. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLogin(_ sender: Any) {
        
        let username = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        PFUser.logInWithUsername(inBackground: username, password: password) {
            (user: PFUser?, error: Error?) -> Void in
            if user != nil {
                print("User logged in successfully")
                //isSuccessful = true
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            } else {
                print(error!.localizedDescription)
            }
        }


    }
    
    @IBAction func onSignin(_ sender: Any) {
        
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = emailTextField.text
        newUser.password = passwordTextField.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) -> Void in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
                // set boolean to true
            }
        }
    }
    
}
