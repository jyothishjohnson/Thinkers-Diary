//
//  NotesViewController.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 01/11/20.
//

import UIKit

typealias NotesCell = GlobalConstants.NotesVC.NotesListCell
typealias EP = GlobalConstants.EndPoints

class NotesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var notes  = [Note]()
    
    let service = NetworkManager.shared
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpViews()
        loadUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
    }
    
    @IBAction func addFolderButtonAction(_ sender: UIButton) {
        
        let alert = UIAlertController.promptForFolderName { folderName  in
            if let name = folderName {
                
                var note = Note()
                note.content = name
                
                self.notes.insert(note, at: 0)
                DispatchQueue.main.async {
                    self.reloadNotesTableView(withScroll: true)
                }
                
                let uploadNote = UploadNote(content: name)
                self.uploadNewNote(note: uploadNote)
            }
        }
        
        present(alert , animated: true)
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
    
    func updateNewNoteId(id : String){
        
        notes[notes.count - 1].id = id
    }
    
    func reloadNotesTableView(withScroll : Bool = false){
        
        self.tableView.reloadData()
        
        if withScroll {
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
    }
    
}

//MARK: - TableView delegate & datasource
extension NotesViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NotesCell.id, for: indexPath) as! NotesListCell
        cell.noteTitle = notes[indexPath.row].content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(notes[indexPath.row])
    }
    
    //MARK: - Remove Note
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let row = indexPath.row
            
            let note = notes[row]
            let delNote = DeleteNote(id: note.id ?? "")
            
            notes.remove(at: row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            deleteNote(note: delNote)
        }
    }
}


//MARK: - API Calls
extension NotesViewController {
    
    func uploadNewNote(note: UploadNote){
        
        let data = try? JSONEncoder().encode(note)
        
        let url = URL(string: "\(EP.ipBaseURL)\(EP.userEndPoint)\(EP.postTodoEndpoint)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = NetworkMethods.POST.rawValue
        request.httpBody = data
        
        service.makeRequest(request) { [weak self] (result: Result<Note, NetworkManagerError>) in
            
            switch result {
            
            case .success(let note):
                
                print(note)
                self?.updateNewNoteId(id: note.id ?? "")
                
            case .failure(let error):
                
                print(error.rawValue)
                print(error.localizedDescription)
            }
        }
        
    }
    
    func loadUserData(for page : Int = 1, with rows : Int = 20){
        
        let url = URL(string: "\(EP.ipBaseURL)\(EP.userEndPoint)\(EP.todosEndpoint)?page=\(page)&per=\(rows)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = NetworkMethods.GET.rawValue
        
        service.makeRequest(request) { (result: Result<PaginatedNotes,NetworkManagerError>) in
            
            switch result {
            
            case .success(let notes):
                self.notes = notes.items ?? []
                DispatchQueue.main.async {
                    self.reloadNotesTableView()
                }
                
            case .failure(let error):
                print(error.rawValue)
                print(error.localizedDescription)
            }
        }
        
    }
    
    func deleteNote(note : DeleteNote){
        
        let data = try? JSONEncoder().encode(note)
        
        let url = URL(string: "\(EP.ipBaseURL)\(EP.userEndPoint)\(EP.deleteTodoEndpoint)")!
        
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
