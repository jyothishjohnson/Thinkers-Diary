//
//  RootViewController.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 20/10/20.
//

import UIKit

class RootViewController: UIViewController {
    
    var vc : UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigateUserFlow()
    }
    
    override func viewDidAppear(_ animated: Bool) {

        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    func navigateUserFlow(){

        if UserDefaults.standard.getIsUserLoggedInStatus() || UserDefaults.standard.getUserLoginSkippedStatus(){
            vc = HomeViewController(nibName: nil, bundle: .main)
        }else{
           
            if UserDefaults.standard.getIsInitialAppUsage() == 0 {
                vc = SignUpViewController(nibName: nil, bundle: .main)
            }else{
                vc = LoginViewController(nibName: nil, bundle: .main)
            }
        }
    }
}
