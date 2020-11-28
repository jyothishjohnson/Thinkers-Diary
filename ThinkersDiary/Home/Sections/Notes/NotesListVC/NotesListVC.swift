//
//  NotesListVC.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 28/11/20.
//

import UIKit

typealias NotesCell = GlobalConstants.NotesVC.NotesListCell

class NotesListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var notes = [Note]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpViews()
    }
    
    func setUpViews(){
        
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func setUpTableView(){
        
        tableView.register(UINib(nibName: NotesCell.id, bundle: .main), forCellReuseIdentifier: NotesCell.id)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
}

//MARK: - Tableview delegate and datasource

extension NotesListVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    
    
}
