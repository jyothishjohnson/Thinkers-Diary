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
    
    private var currentTabPosition = 0
    
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
        if UserDefaults.standard.getNetworkStatusisActive(){
            add(asChildViewController: tabsDataSource[position]!, containerView: containerView)
            
        }else{
            //FIXME: Add no network code here
        }
    }
}

//MARK: - NetworkConnectionUpdateDelegate

extension HomeViewController :ConnectionUpdateDelegate {
    
    func connectionDidUpdate() {
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
