//
//  ProfileViewController.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 09/02/21.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = title
    }

}
