//
//  RemindersViewController.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 14/11/20.
//

import UIKit

class RemindersViewController: UIViewController {

    @IBOutlet weak var topView: HeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    func setUpViews(){
        self.navigationController?.setToolbarItems([UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)], animated: true)
        topView.rightButtonImageName = ("plus", true)
        topView.rightButtonAction = {
            let vc = NewReminderViewController(nibName: "NewReminderViewController", bundle: .main)
            vc.modalPresentationStyle = .popover
            self.navigationController?.present(vc, animated: true)
        }
    }
    
}
