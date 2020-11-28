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
    
    let service = NetworkManager.shared
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpViews()
        loadUserNotes()
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
    
    func reloadNotesTableView(withScroll : Bool = false){
        
        self.tableView.reloadData()
        
        if withScroll {
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
    }
}

//MARK: - Tableview delegate and datasource

extension NotesListVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NotesCell.id, for: indexPath) as! NotesListCell
        cell.noteTitle = notes[indexPath.row].name
        return cell
    }
    
    
    
}

//MARK: - Data Tasks

extension NotesListVC {
    
    func loadUserNotes(for page : Int = 1, with rows : Int = 20, isFromRefresh : Bool = false){
        
        let url = URL(string: "\(EP.ipBaseURL)\(EP.paginatedNotes)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = NetworkMethods.GET.rawValue
        
        service.makeRequest(request) { (result: Result<PaginatedNotes,NetworkManagerError>) in
            
            switch result {
            
            case .success(let response):
                self.notes = response.items ?? []
                DispatchQueue.main.async {
                    self.reloadNotesTableView()
                }
                
            case .failure(let error):
                print(error.rawValue)
                print(error.localizedDescription)
            }
            
            if isFromRefresh {
                DispatchQueue.main.async {
//                    self.refreshControl.endRefreshing()
                }
            }
        }
        
    }
}
