//
//  NotesViewController.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 01/11/20.
//

import UIKit

class NotesViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        name.text = title
    }
}
