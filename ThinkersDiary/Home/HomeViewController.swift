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
        tabsView.delegate = self
        setData()
        print(UserDefaults.standard.getUserLoginSkippedStatus())
        print(UserDefaults.standard.getIsUserLoggedInStatus())
    }
    
    func setData(){
        tabsDataSource = HomeTabDataSource(self).data
        tabsView.datasource = tabsDataSource.map{
            $0?.title ?? ""
        }
    }
    
//    @IBAction func logoutAction(_ sender: UIButton) {
//        UserDefaults.standard.setIsUserLoggedInStatus(false)
//        self.dismiss(animated: false, completion: nil)
//    }
}

extension HomeViewController : TabsMenuDelegate {
    
    func menuDidSelect(position: Int) {
        print(position)
    }
}

enum HomeTabs {
    
    case notes
    case todos
    case diary
    case profile
}
