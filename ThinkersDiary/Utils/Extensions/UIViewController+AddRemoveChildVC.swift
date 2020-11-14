//
//  UIViewController+AddRemoveChildVC.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 14/11/20.
//

import UIKit

extension UIViewController {
    
    func add(asChildViewController viewController: UIViewController, containerView : UIView) {
        
        addChild(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.frame = containerView.bounds
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
