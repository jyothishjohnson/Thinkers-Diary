//
//  HomeViewController.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 20/10/20.
//

import UIKit

class HomeViewController: UserFlowDelegateAdapterVC {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tabsView: TabsView!
    
    lazy var networkObserver = NetworkObserver.shared
    
    var tabsDataSource : [UIViewController?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabsView.delegate = self
        setData()
        networkObserver.delegate = self
    }
    
    func setData(){
        tabsDataSource = HomeTabDataSource(self).data
        tabsView.datasource = tabsDataSource.map{
            $0?.title ?? ""
        }
        selectController(at: 0, containerView: containerView)
    }
    
//    @IBAction func logoutAction(_ sender: UIButton) {
//        UserDefaults.standard.setIsUserLoggedInStatus(false)
//        self.dismiss(animated: false, completion: nil)
//    }
}

extension HomeViewController : TabsMenuDelegate {
    
    func menuDidSelect(position: Int) {
        loadController(at: position)
    }
}

//MARK: - Add Remove Child Viewcontrollers
extension HomeViewController {
    
    private func loadController(at position: Int){
        removeAllChilds {
            selectController(at: position, containerView: containerView)
        }
    }
    
    func selectController(at position : Int, containerView : UIView){
        add(asChildViewController: tabsDataSource[position]!, containerView: containerView)
    }
}

//MARK: - NetworkConnectionUpdateDelegate

extension HomeViewController :ConnectionUpdateDelegate {
    
    func connectionDidUpdate() {
        print(networkObserver.isActive)
        print(networkObserver.isConstrained)
        print(networkObserver.isExpensive)
        print(networkObserver.connectionType)
    }
}

enum HomeTabs {
    
    case notes
    case todos
    case diary
    case profile
}
