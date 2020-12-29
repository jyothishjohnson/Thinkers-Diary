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
    private lazy var dataSource = makeDataSource()
    
    let service = NetworkManager.shared
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpViews()
        loadUserFoldersFromAPI()
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
        tableView.dataSource = dataSource
        tableView.tableFooterView = UIView()
        tableView.addSubview(self.refreshControl)
    }
    
    func setUpButtonActions(){
        topHeaderView.buttonAction = { [unowned self] in
            
            let alert = UIAlertController.prompt(title: "Enter folder name") { folderName  in
                if let name = folderName {
                    
                    let folder = Folder(id: UUID().uuidString, name: name)
                    
                    self.folders.insert(folder, at: 0)
                    DispatchQueue.main.async {
                        self.loadDataSource(animated: true)
                    }
                    
                    let newFolder = NewFolder(id: folder.id, name: name)
                    
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
extension NotesFolderViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        let vc = NotesListVC(nibName: "NotesListVC", bundle: .main)
        vc.currentFolderId = folders[indexPath.row].id
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //MARK: - Remove Folder
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "Delete") {  [unowned self] (contextualAction, view, completion) in
            if let folder = self.dataSource.itemIdentifier(for: indexPath) {
                var currentSnapshot = self.dataSource.snapshot()
                currentSnapshot.deleteItems([folder])
                self.dataSource.apply(currentSnapshot)
                
                let delFolder = DeleteFolder(id: folder.id)
                deleteFolder(folder: delFolder)
            }
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        swipeActions.performsFirstActionWithFullSwipe = false
        return swipeActions
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
    
    func loadUserFoldersFromAPI(for page : Int = 1, with rows : Int = 20, isFromRefresh : Bool = false){
        
        let url = URL(string: "\(EP.ipBaseURL)\(EP.allUserFolders)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = NetworkMethods.GET.rawValue
        
        service.makeRequest(request) { [weak self] (result: Result<[Folder],NetworkManagerError>) in
            
            switch result {
            
            case .success(let folders):
                self?.folders = folders
                DispatchQueue.main.async {
                    self?.loadDataSource()
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
        loadUserFoldersFromAPI(isFromRefresh: true)
    }
}

//MARK: - Diffable Data Source

extension NotesFolderViewController {
    
    func makeDataSource() -> CustomDiffDataSource{
        
        return CustomDiffDataSource(
            tableView: tableView,
            cellProvider: { tableView, indexPath, folder in
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: FoldersCell.id,
                    for: indexPath) as! FolderListCell
                
                cell.folderName = folder.name
                
                return cell
        })
    }
    
    func loadDataSource(animated: Bool = false) {
        var snapshot = NSDiffableDataSourceSnapshot<FolderVCSections, Folder>()
        snapshot.appendSections(FolderVCSections.allCases)
        snapshot.appendItems(folders, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
}

enum FolderVCSections: CaseIterable {
    case main
}

class CustomDiffDataSource: UITableViewDiffableDataSource<FolderVCSections, Folder> {
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
}


