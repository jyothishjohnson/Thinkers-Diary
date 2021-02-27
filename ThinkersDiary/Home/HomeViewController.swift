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
    
    private var currentTabPosition = 1
    
    var homeTabDataSource : HomeTabDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTabDataSource = HomeTabDataSource(self)
        tabsView.delegate = self
        networkObserver.delegate = self
        setData()
    }
    
    func setData(){
        tabsDataSource = homeTabDataSource.data
        tabsView.datasource = (tabsDataSource.map{
            $0?.title ?? ""
        },
        homeTabDataSource.iconNames,currentTabPosition)
        selectController(at: currentTabPosition, containerView: containerView)
    }

}

extension HomeViewController : TabsMenuDelegate {
    
    func menuDidSelect(position: Int) {
        loadController(at: position)
        currentTabPosition = position
    }
}

//MARK: - Add Remove Child Viewcontrollers
extension HomeViewController {
    
    private func loadController(at position: Int){
        DispatchQueue.main.async {
            self.removeAllChilds {
                self.selectController(at: position, containerView: self.containerView)
            }
        }
    }
    
    func selectController(at position : Int, containerView : UIView){
        
        add(asChildViewController: tabsDataSource[position]!, containerView: containerView)

//        if UserDefaults.standard.getNetworkStatusisActive(){
//
//        }else{
//            //FIXME: Add no network code here
//        }
    }
}

//MARK: - NetworkConnectionUpdateDelegate

extension HomeViewController :ConnectionUpdateDelegate {
    
    func connectionDidUpdate() {
        print(#function)
        UserDefaults.standard.setNetworkStatusisActive(networkObserver.isActive)
        loadController(at: currentTabPosition)
    }
}

enum HomeTabs {
    
    case notes
    case todos
    case diary
    case profile
}
