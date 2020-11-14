//
//  NotesViewController.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 01/11/20.
//

import UIKit

typealias NotesCell = GlobalConstants.NotesVC.NotesListCell

class NotesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var notes  = [String]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func setUpViews(){
        setUpTableView()
    }
    
    func setUpTableView(){
        tableView.register(UINib(nibName: NotesCell.id, bundle: .main), forCellReuseIdentifier: NotesCell.id)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func addFolderButtonAction(_ sender: UIButton) {
        
        let alert = UIAlertController.promptForFolderName { folderName  in
            if let name = folderName {
                self.notes.append(name)
                self.tableView.reloadData()
            }
        }
        
        present(alert , animated: true)
    }
}

extension NotesViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NotesCell.id, for: indexPath) as! NotesListCell
        cell.noteTitle = notes[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(notes[indexPath.row])
    }
}
