//
//  ViewController.swift
//  Emotions
//
//  Created by Artem Khlevchuk on 30.03.2024.
//

import UIKit
import FirebaseAuth

class WelcomeViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
      
        // Do any additional setup after loading the view.
    }

    @IBAction func signInPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                    self.performSegue(withIdentifier: "LoginToMainScreen", sender: self)
                }
                
                
                
            }
            
        }

    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return passwordTextField.resignFirstResponder()
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
  
}

