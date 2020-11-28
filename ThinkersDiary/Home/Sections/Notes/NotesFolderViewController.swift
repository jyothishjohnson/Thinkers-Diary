//
//  NotesViewController.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 01/11/20.
//

import UIKit

typealias NotesCell = GlobalConstants.NotesVC.NotesListCell
typealias FoldersCell = GlobalConstants.NotesVC.FolderListCell
typealias EP = GlobalConstants.EndPoints
typealias Folder = FolderResponseDTO
typealias NewFolder = NewFolderRequestDTO
typealias DeleteFolder = DeleteFolderRequestDTO

class NotesFolderViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh),for: .valueChanged)
        refreshControl.tintColor = #colorLiteral(red: 0, green: 0.6366431752, blue: 1, alpha: 1)
        
        return refreshControl
    }()
    
    var folders  = [Folder]()
    
    let service = NetworkManager.shared
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpViews()
        loadUserFolders()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
    }
    
    @IBAction func addFolderButtonAction(_ sender: UIButton) {
        
        let alert = UIAlertController.promptForFolderName { folderName  in
            if let name = folderName {
                
                var folder = Folder()
                folder.name = name
                folder.id = UUID().uuidString
                
                self.folders.insert(folder, at: 0)
                DispatchQueue.main.async {
                    self.reloadNotesTableView(withScroll: true)
                }
                
                let newFolder = NewFolder(id: folder.id!, name: name)
                
                self.addNewFolder(note: newFolder)
            }
        }
        
        present(alert , animated: true)
    }
    
    func setUpViews(){
        setUpTableView()
    }
    
    func setUpTableView(){
        tableView.register(UINib(nibName: FoldersCell.id, bundle: .main), forCellReuseIdentifier: FoldersCell.id)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.addSubview(self.refreshControl)
    }

    func reloadNotesTableView(withScroll : Bool = false){
        
        self.tableView.reloadData()
        
        if withScroll {
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
    }
    
}

//MARK: - TableView delegate & datasource
extension NotesFolderViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        folders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FoldersCell.id, for: indexPath) as! FolderListCell
        cell.folderName = folders[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(folders[indexPath.row])
    }
    
    //MARK: - Remove Note
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let row = indexPath.row

            let folder = folders[row]
            let delFolder = DeleteFolder(id: folder.id ?? "")

            folders.remove(at: row)
            tableView.deleteRows(at: [indexPath], with: .fade)

            deleteFolder(folder: delFolder)
        }
    }
}


//MARK: - API Calls
extension NotesFolderViewController {
    
    func addNewFolder(note: NewFolder){
        
        let data = try? JSONEncoder().encode(note)
        
        let url = URL(string: "\(EP.ipBaseURL)\(EP.addNewFolder)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = NetworkMethods.POST.rawValue
        request.httpBody = data
        
        service.makeRequest(request) { (result: Result<Folder, NetworkManagerError>) in
            
            switch result {
            
            case .success(let folder):
                
                print(folder)
                
            case .failure(let error):
                
                print(error.rawValue)
                print(error.localizedDescription)
            }
        }
        
    }
    
    func loadUserFolders(for page : Int = 1, with rows : Int = 20, isFromRefresh : Bool = false){
        
        let url = URL(string: "\(EP.ipBaseURL)\(EP.allUserFolders)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = NetworkMethods.GET.rawValue
        
        service.makeRequest(request) { (result: Result<[Folder],NetworkManagerError>) in
            
            switch result {
            
            case .success(let folders):
                self.folders = folders
                DispatchQueue.main.async {
                    self.reloadNotesTableView()
                }
                
            case .failure(let error):
                print(error.rawValue)
                print(error.localizedDescription)
            }
            
            if isFromRefresh {
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                }
            }
        }
        
    }
    
    func deleteFolder(folder : DeleteFolder){
        
        let data = try? JSONEncoder().encode(folder)
        
        let url = URL(string: "\(EP.ipBaseURL)\(EP.deleteFolder)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = NetworkMethods.DELETE.rawValue
        request.httpBody = data
        
        service.makeRequest(request) { (result: Result<Int, NetworkManagerError>) in
            
            switch result {
            
            case .success(let code):
                
                print(code)
                
            case .failure(let error):
                
                print(error.rawValue)
                print(error.localizedDescription)
            }
        }
        
    }
}

//MARK: - Refresh Notes
extension NotesFolderViewController {
    
    @objc func handleRefresh() {
        self.refreshControl.beginRefreshing()
        loadUserFolders(isFromRefresh: true)
    }
}
