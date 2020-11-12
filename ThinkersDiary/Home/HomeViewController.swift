//
//  HomeViewController.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 20/10/20.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tabsView: TabsView!
    
    var tabsDataSource : [UIViewController?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabsDataSource = HomeTabDataSource(self).data
        tabsView.datasource = tabsDataSource
        print(UserDefaults.standard.getUserLoginSkippedStatus())
        print(UserDefaults.standard.getIsUserLoggedInStatus())
    }
    
//    @IBAction func logoutAction(_ sender: UIButton) {
//        UserDefaults.standard.setIsUserLoggedInStatus(false)
//        self.dismiss(animated: false, completion: nil)
//    }
}

enum HomeTabs {
    
    case notes
    case todos
    case diary
    case profile
}
