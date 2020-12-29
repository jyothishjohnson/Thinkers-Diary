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
    @IBOutlet weak var topHeaderView: HeaderView!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh),for: .valueChanged)
        refreshControl.tintColor = #colorLiteral(red: 0, green: 0.6366431752, blue: 1, alpha: 1)
        
        return refreshControl
    }()
    
    var notes = [Note]()
    
    var currentFolderId : String?
    
    let service = NetworkManager.shared
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpViews()
        loadUserNotes()
    }
    
    func setUpViews(){
        
        setUpTableView()
        setUpButtonActions()
    }
    
    func setUpTableView(){
        
        tableView.register(UINib(nibName: NotesCell.id, bundle: .main), forCellReuseIdentifier: NotesCell.id)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.addSubview(refreshControl)
    }
    
    func setUpButtonActions(){
        topHeaderView.rightButtonImageName = (name: "plus",isSystemImage: true)
        topHeaderView.buttonAction = { [unowned self] in
            
            let alert = UIAlertController.prompt(title: "Enter note name") { noteName  in
                
                guard let currentFolder = self.currentFolderId else {
                    
                    self.present(UIAlertController.showMessage(title: "Error", "Folder id error", nil), animated: true, completion: nil)
                    return
                }
                
                if let name = noteName {
                    
                    var note = Note()
                    note.name = name
                    note.id = UUID().uuidString
                    
                    self.notes.insert(note, at: 0)
                    DispatchQueue.main.async {
                        self.reloadNotesTableView(withScroll: true)
                    }
                    
                    
                    let newNote = UploadNote(id: note.id!, name: name, folderId: currentFolder)
                    self.addNewNote(note: newNote)
                    
                }
            }
            
            present(alert, animated: true, completion: nil)
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = NoteViewController(nibName: "NoteViewController", bundle: .main)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

//MARK: - Data Tasks

extension NotesListVC {
    
    func addNewNote(note: UploadNote){
        
        let data = try? JSONEncoder().encode(note)
        
        let url = URL(string: "\(EP.ipBaseURL)\(EP.addNewNote)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = NetworkMethods.POST.rawValue
        request.httpBody = data
        
        service.makeRequest(request) { (result: Result<Note, NetworkManagerError>) in
            
            switch result {
            
            case .success(let note):
                
                print(note)
                
            case .failure(let error):
                
                print(error.rawValue)
                print(error.localizedDescription)
            }
        }
        
    }
    
    func loadUserNotes(for page : Int = 1, with rows : Int = 20, isFromRefresh : Bool = false){
        
        guard let folderId = currentFolderId else {
            return
        }
        
        let url = URL(string: "\(EP.ipBaseURL)\(EP.paginatedNotes)\(folderId)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = NetworkMethods.GET.rawValue
        
        service.makeRequest(request) { [weak self] (result: Result<PaginatedNotes,NetworkManagerError>) in
             
            switch result {
            
            case .success(let response):
                self?.notes = response.items ?? []
                DispatchQueue.main.async {
                    self?.reloadNotesTableView()
                }
                
            case .failure(let error):
                print(error.rawValue)
                print(error.localizedDescription)
            }
            
            if isFromRefresh {
                DispatchQueue.main.async {
                    self?.refreshControl.endRefreshing()
                }
            }
        }
        
    }
}

//MARK: - Refresh Notes
extension NotesListVC {
    
    @objc func handleRefresh() {
        self.refreshControl.beginRefreshing()
        loadUserNotes(isFromRefresh: true)
    }
}
