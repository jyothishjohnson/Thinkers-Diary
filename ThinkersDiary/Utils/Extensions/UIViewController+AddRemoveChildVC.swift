//
//  UIViewController+AddRemoveChildVC.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 14/11/20.
//

import UIKit

extension UIViewController {
    
    func add(asChildViewController viewController: UIViewController, containerView : UIView) {
        
        viewController.view.frame = containerView.bounds
        containerView.addSubview(viewController.view)
        addChild(viewController)
        viewController.didMove(toParent: self)
    }
    
    func removeAllChilds(_ onCompletion: () -> ()) {
        
        let viewcontrollers = self.children
        for viewController in viewcontrollers {
            
            viewController.willMove(toParent: nil)
            viewController.view.removeFromSuperview()
            viewController.removeFromParent()
        }
        onCompletion()
    }
}
