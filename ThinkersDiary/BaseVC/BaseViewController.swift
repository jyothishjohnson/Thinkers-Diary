//
//  BaseViewController.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 01/12/20.
//

import UIKit

class BaseViewController: UIViewController {
    
    static let shared = BaseViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadRootVC()
    }
    
    func loadRootVC(){
        print("Loading root from base")
        let rootVC = RootViewController(nibName: "RootViewController", bundle: .main)
        self.add(asChildViewController: rootVC, containerView: self.view)
    }
}
