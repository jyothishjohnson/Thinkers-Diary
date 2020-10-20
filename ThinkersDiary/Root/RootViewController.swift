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
        present(vc, animated: false, completion: nil)
    }
    
    func navigateUserFlow(){

        if UserDefaults.standard.getIsUserLoggedInStatus(){
            vc = HomeViewController(nibName: "HomeViewController", bundle: .main)
        }else{
            vc = LoginViewController(nibName: "LoginViewController", bundle: .main)
        }
    }
}
