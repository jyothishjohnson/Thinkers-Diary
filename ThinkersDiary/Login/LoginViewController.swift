//
//  LoginViewController.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 20/10/20.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let cornerRadius = CGFloat(4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    @IBAction func loginAction(_ sender: Any) {
        UserDefaults.standard.setIsUserLoggedInStatus(true)
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func skipLoginAction(_ sender: UIButton) {
        
        UserDefaults.standard.setUserLoginSkippedStatus(true)
        self.dismiss(animated: false, completion: nil)
    }
    
    func setupViews(){
        
        let attributedString = NSMutableAttributedString.makeAttributedWelcomeString(GlobalConstants.Welcome.welcomeString)
        welcomeLabel.attributedText = attributedString
        passwordTF.layer.cornerRadius = cornerRadius
        emailTF.layer.cornerRadius = cornerRadius
        loginButton.layer.cornerRadius = cornerRadius
        
        passwordTF.placeholder = "Password"
        emailTF.placeholder = "Email Address"
        
        passwordTF.isSecureTextEntry = true
    }
    
}
