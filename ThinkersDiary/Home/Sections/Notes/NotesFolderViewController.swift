//
//  NotesViewController.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 01/11/20.
//

import UIKit

typealias FoldersCell = GlobalConstants.NotesVC.FolderListCell
typealias EP = GlobalConstants.EndPoints
typealias Folder = FolderResponseDTO
typealias NewFolder = NewFolderRequestDTO
typealias DeleteFolder = DeleteFolderRequestDTO

fileprivate enum NotesFolderCells: String, CaseIterable {
    case FolderListCell
}

class NotesFolderViewController: UIViewController {
    
    @IBOutlet weak var topHeaderView: HeaderView!
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
    
    func setUpViews(){
        setUpTableView()
        setUpButtonActions()
    }
    
    func setUpTableView(){
        registerCells()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.addSubview(self.refreshControl)
    }
    
    func setUpButtonActions(){
        topHeaderView.buttonAction = { [unowned self] in
            
            let alert = UIAlertController.prompt(title: "Enter folder name") { folderName  in
                if let name = folderName {
                    
                    var folder = Folder()
                    folder.name = name
                    folder.id = UUID().uuidString
                    
                    self.folders.insert(folder, at: 0)
                    DispatchQueue.main.async {
                        self.reloadFoldersTableView(withScroll: true)
                    }
                    
                    let newFolder = NewFolder(id: folder.id!, name: name)
                    
                    self.addNewFolder(folder: newFolder)
                }
            }
            
            self.present(alert , animated: true)
        }
    }
    
    func registerCells(){
        for celltype in NotesFolderCells.allCases {
            tableView.register(UINib(nibName: celltype.rawValue, bundle: .main), forCellReuseIdentifier: celltype.rawValue)
        }
    }

    func reloadFoldersTableView(withScroll : Bool = false){
        
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
        print(indexPath.row)
        
        let vc = NotesListVC(nibName: "NotesListVC", bundle: .main)
        vc.currentFolderId = folders[indexPath.row].id
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
    
    func addNewFolder(folder: NewFolder){
        
        let data = try? JSONEncoder().encode(folder)
        
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
        
        service.makeRequest(request) { [weak self] (result: Result<[Folder],NetworkManagerError>) in
            
            switch result {
            
            case .success(let folders):
                self?.folders = folders
                DispatchQueue.main.async {
                    self?.reloadFoldersTableView()
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

//MARK: - Refresh Folders
extension NotesFolderViewController {
    
    @objc func handleRefresh() {
        self.refreshControl.beginRefreshing()
        loadUserFolders(isFromRefresh: true)
    }
}
