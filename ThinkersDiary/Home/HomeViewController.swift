//
//  HomeViewController.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 20/10/20.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(UserDefaults.standard.getUserLoginSkippedStatus())
        print(UserDefaults.standard.getIsUserLoggedInStatus())
    }
    
    @IBAction func logoutAction(_ sender: UIButton) {
        UserDefaults.standard.setIsUserLoggedInStatus(false)
        self.dismiss(animated: false, completion: nil)
    }
}
