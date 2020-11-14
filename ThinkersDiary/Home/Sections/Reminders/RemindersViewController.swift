//
//  RemindersViewController.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 14/11/20.
//

import UIKit

class RemindersViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = title
    }
}
