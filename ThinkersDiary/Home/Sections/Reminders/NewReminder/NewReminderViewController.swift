//
//  NewReminderViewController.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 27/02/21.
//

import UIKit

class NewReminderViewController: UIViewController {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var eventNameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        
    }
    
    func setUpViews(){
        saveButton.layer.cornerRadius = 6
    }

}

