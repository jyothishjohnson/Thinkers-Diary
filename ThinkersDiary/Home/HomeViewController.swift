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
    }
    
    func setData(){
        tabsDataSource = HomeTabDataSource(self).data
        tabsView.datasource = tabsDataSource.map{
            $0?.title ?? ""
        }
        selectController(at: 0)
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
            selectController(at: position)
        }
    }
    
    func selectController(at position : Int){
        add(asChildViewController: tabsDataSource[position]!)
    }
    
    private func add(asChildViewController viewController: UIViewController) {

        addChild(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.frame = containerView.bounds
        viewController.didMove(toParent: self)
    }



    private func removeAllChilds(_ onCompletion: () -> ()) {

        let viewcontrollers = self.children
        for viewController in viewcontrollers {

            viewController.willMove(toParent: nil)
            viewController.view.removeFromSuperview()
            viewController.removeFromParent()
        }
        onCompletion()
    }
}

enum HomeTabs {
    
    case notes
    case todos
    case diary
    case profile
}
