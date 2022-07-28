//
//  ViewController.swift
//  CartonTodo
//
//  Created by ohhyung kwon on 28/7/2022.
//

import UIKit

class LogInController: UIViewController {
    
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logInButton.filled()
    }
    
    @IBAction func logInAction(_ sender: Any) {
        let _ = resignFirstResponder()
        
        guard let userId = userIdTextField.text, !userId.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else{
            
            showAlert(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("Type valid user id and password.", comment: ""))
            
            return
        }
        
        LoginManager.shared.isLogin = true
    }

    override func resignFirstResponder() -> Bool {
        passwordTextField.resignFirstResponder()
        userIdTextField.resignFirstResponder()
        
        return super.resignFirstResponder()
    }
}
