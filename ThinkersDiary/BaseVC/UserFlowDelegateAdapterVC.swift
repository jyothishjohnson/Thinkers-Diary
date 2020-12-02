//
//  UserFlowDelegateAdapterVC.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 02/12/20.
//

import UIKit

protocol SignUpDelegate: class{
    
    func skipSignUp()
    func signUpSuccess()
}

class UserFlowDelegateAdapterVC: UIViewController {
    

    weak var delegate : SignUpDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
