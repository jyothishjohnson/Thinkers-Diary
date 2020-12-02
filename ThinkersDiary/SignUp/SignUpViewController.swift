//
//  SignUpViewController.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 26/10/20.
//

import UIKit

class SignUpViewController: UserFlowDelegateAdapterVC {

    @IBOutlet weak var signUpMessageLabel: UILabel!
    @IBOutlet weak var signUpPasswordTF: UITextField!
    @IBOutlet weak var signUpEmailTF: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signUpPasswordConfirmTF: UITextField!
    
    let cornerRadius = CGFloat(4)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        
        //FIXME:- Redirect to login page on success
        UserDefaults.standard.setIsUserLoggedInStatus(true)
        UserDefaults.standard.setIsInitialAppUsage(1)
        delegate?.signUpSuccess()
//        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func skipSignUpAction(_ sender: UIButton) {
        
        UserDefaults.standard.setUserLoginSkippedStatus(true)
        delegate?.skipSignUp()
//        self.dismiss(animated: false, completion: nil)
    }
    
    func setupViews(){
        
        let attributedString = NSMutableAttributedString.makeAttributedWelcomeString(GlobalConstants.Welcome.firstTimeString)
        signUpMessageLabel.attributedText = attributedString
        
        signUpPasswordTF.layer.cornerRadius = cornerRadius
        signUpEmailTF.layer.cornerRadius = cornerRadius
        signUpButton.layer.cornerRadius = cornerRadius
        
        signUpPasswordTF.placeholder = "Password"
        signUpPasswordConfirmTF.placeholder = "Confirm Password"
        signUpEmailTF.placeholder = "Email Address"
        
        signUpPasswordTF.isSecureTextEntry = true
        signUpPasswordConfirmTF.isSecureTextEntry = true
    }
}
