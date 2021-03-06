//
//  RootViewController.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 20/10/20.
//

import UIKit

class RootViewController: UIViewController {
    
    var vc : UserFlowDelegateAdapterVC!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigateUserFlow()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.add(asChildViewController: vc, containerView: self.view)
    }
    
    func navigateUserFlow(){

        if UserDefaults.standard.getIsUserLoggedInStatus() || UserDefaults.standard.getUserLoginSkippedStatus(){
            vc = HomeViewController(nibName: nil, bundle: .main)
        }else{
           
            if UserDefaults.standard.getIsInitialAppUsage() == 0 {
                vc = SignUpViewController(nibName: nil, bundle: .main)
                vc.delegate = self
            }else{
                vc = LoginViewController(nibName: nil, bundle: .main)
            }
        }
    }
    
}


//MARK: - Signup delegate

extension RootViewController : SignUpDelegate {
    
    func skipSignUp() {
        
        removeAllChilds {
            navigateUserFlow()
            self.add(asChildViewController: vc, containerView: self.view)
        }
    }
    
    func signUpSuccess() {
        
        removeAllChilds {
            navigateUserFlow()
            self.add(asChildViewController: vc, containerView: self.view)
        }
    }
}
