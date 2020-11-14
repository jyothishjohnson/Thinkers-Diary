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
        setUpViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        name.text = title
    }
    
    func setUpViews(){
        
    }
    
    @IBAction func addFolderButtonAction(_ sender: UIButton) {
        
        let alert = UIAlertController.promptForFolderName { folderName  in
            if let name = folderName {
                print(name)
            }
        }
        
        present(alert , animated: true)
    }
}
