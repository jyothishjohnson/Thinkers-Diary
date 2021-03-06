//
//  NotesListVC.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 28/11/20.
//

import UIKit

typealias NotesCell = GlobalConstants.NotesVC.NotesListCell

fileprivate enum NotesListCells: String, CaseIterable {
    case NotesListCell
}

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
    
    private lazy var dataSource = makeDataSource()
    
    var currentFolderId : String?
    
    var loader : NotesLoader<PaginatedNotes>!
    
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
        
        registerCells()
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.tableFooterView = UIView()
        tableView.addSubview(refreshControl)
    }
    
    func registerCells(){
        
        for cellType in NotesListCells.allCases{
            tableView.register(UINib(nibName: cellType.rawValue, bundle: .main), forCellReuseIdentifier: cellType.rawValue)
        }
    }
    
    func setUpButtonActions(){
        topHeaderView.leftButtonImageName = ("chevron.left", true)
        topHeaderView.leftButtonAction = { [unowned self] in
            print("left button")
            self.navigationController?.popViewController(animated: true)
        }
        topHeaderView.rightButtonImageName = (name: "plus",isSystemImage: true)
        topHeaderView.rightButtonAction = { [unowned self] in
            
            let alert = UIAlertController.prompt(title: "Enter note name") { noteName  in
                
                guard let currentFolder = self.currentFolderId else {
                    
                    self.present(UIAlertController.showMessage(title: "Error", "Folder id error", nil), animated: true, completion: nil)
                    return
                }
                
                if let name = noteName {
                    let id = UUID().uuidString
                    let note = Note(id: id, name: name, content: nil)
                    
                    self.notes.insert(note, at: 0)
                    DispatchQueue.main.async {
                        self.loadDataSource(animated: true)
                    }
                    
                    
                    let newNote = UploadNote(id: note.id, name: name, folderId: currentFolder)
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

extension NotesListVC : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        54
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = NoteViewController(nibName: "NoteViewController", bundle: .main)
        vc.noteId = notes[indexPath.row].id
        vc.content = notes[indexPath.row].content
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let contextItem = UIContextualAction(style: .destructive, title: "Delete") {  [unowned self] (contextualAction, view, completion) in
            if let note = self.dataSource.itemIdentifier(for: indexPath) {
                var currentSnapshot = self.dataSource.snapshot()
                currentSnapshot.deleteItems([note])
                self.dataSource.apply(currentSnapshot)
                
                let delNote = DeleteNote(id: note.id)
                deleteNote(note: delNote)
            }
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        swipeActions.performsFirstActionWithFullSwipe = false
        return swipeActions
    }
}

//MARK: - Data Tasks

extension NotesListVC {
    
    func addNewNote(note: UploadNote){
        
        loader.addItem(item: note) { (res) in
            
            switch res {
            
            case .success(let note):
                print(note.name)
                
            case .failure(let error):
                
                print(error.rawValue)
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteNote(note :DeleteNote){
        
        loader.deleteItem(item: note) { (res) in
            
            switch res {
            case .success(let statusCode):
                
                print(statusCode)
                
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
        
        loader.loadItems(from: folderId) { [weak self] (res) in
            
            switch res {
            
            case .success(let response):
                self?.notes = response.items ?? []
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
}

//MARK: - Refresh Notes
extension NotesListVC {
    
    @objc func handleRefresh() {
        self.refreshControl.beginRefreshing()
        loadUserNotes(isFromRefresh: true)
    }
}

//MARK: - Diffable DS

extension NotesListVC {
    
    private func makeDataSource() ->CustomNotesDiffDataSource {
        
        return CustomNotesDiffDataSource(
            tableView: tableView) { (tableview, indexPath, note) -> UITableViewCell? in
            
            let cell = tableview.dequeueReusableCell(withIdentifier: NotesCell.id, for: indexPath) as! NotesListCell
            cell.noteTitle = note.name
            return cell
        }
    }
    
    func loadDataSource(animated: Bool = false) {
        var snapshot = NSDiffableDataSourceSnapshot<NoteVCSections, Note>()
        snapshot.appendSections(NoteVCSections.allCases)
        snapshot.appendItems(notes, toSection: .notes)
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
}

private enum NoteVCSections: CaseIterable {
    case notes
}

fileprivate class CustomNotesDiffDataSource: UITableViewDiffableDataSource<NoteVCSections, Note> {
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
}
