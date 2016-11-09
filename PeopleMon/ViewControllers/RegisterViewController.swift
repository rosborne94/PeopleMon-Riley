//
//  RegisterViewController.swift
//  PeopleMon
//
//  Created by Riley Osborne on 11/7/16.
//  Copyright © 2016 Riley Osborne. All rights reserved.
//

import UIKit
import MBProgressHUD

class RegisterViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPwdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    //MARK: - IBAction
    @IBAction func registerButton(_ sender: UIButton) {
        //Validate user input
        guard let fullName = usernameTextField.text , fullName != "" else {
            let alert = Utils.createAlert("Login Error", message: "Please provide a username", dismissButtonTitle: "Close")
            present(alert, animated: true, completion: nil)
            return
        }
        guard let email = emailTextField.text , email != "" else {
            let alert = Utils.createAlert("Login Error", message: "Please provide a email", dismissButtonTitle: "Close")
            present(alert, animated: true, completion: nil)
            return
        }
        guard let password = passwordTextField.text , password != "" else {
            let alert = Utils.createAlert("Login Error", message: "Please provide a password", dismissButtonTitle: "Close")
            present(alert, animated: true, completion: nil)
            return
        }
        guard let confirmPwd = confirmPwdTextField.text , confirmPwd != "" else {
            let alert = Utils.createAlert("Login Error", message: "Passwords do not match", dismissButtonTitle: "Close")
            present(alert, animated: true, completion: nil)
            return
        }
        
        
        // Going to go ahead with the register
        MBProgressHUD.showAdded(to: view, animated: true)
        
        let user = User(email: email, password: password, fullName: fullName)
        
        UserStore.shared.register(user) { (success, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            
            if success {
                self.dismiss(animated: true, completion: nil)
            } else if let error = error {
                self.present(Utils.createAlert(message: error), animated: true, completion: nil)
            } else {
                self.present(Utils.createAlert(message: Constants.JSON.unknownError), animated: true, completion: nil)
            }
        }
    }
}
