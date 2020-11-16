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
    
    var notes  = [Note]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpViews()
        loadUserData()
    }
    
    @IBAction func addFolderButtonAction(_ sender: UIButton) {
        
        let alert = UIAlertController.promptForFolderName { folderName  in
            if let name = folderName {
                
                var note = Note()
                note.id = UUID().uuidString
                note.content = name
                
                self.notes.append(note)
                self.tableView.reloadData()
            }
        }
        
        present(alert , animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
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
    
    func loadUserData(){
        let url = URL(string: "http://192.168.43.228:8080/user/todos/all")!
        var request = URLRequest(url: url)
        request.httpMethod = NetworkMethods.GET.rawValue
        
        let service = NetworkManager.shared
        service.makeRequest(request) { (result: Result<[Note],NetworkManagerError>) in
            
            switch result {
                
            case .success(let notes):
                self.notes = notes
                DispatchQueue.main.async {
                    self.reloadNotesTableView()
                }
                
            case .failure(let error):
                switch error {
                
                case .NoData:
                    print("no data")
                case .ServerError:
                    print("server")
                case .Forbidden:
                    print("forbidden")
                case .DataDecodingError:
                    print("data decoding")
                case .UnknownError:
                    print("unknown")
                }
                print(error.localizedDescription)
            }
        }
        
    }
    
    func reloadNotesTableView(){
        self.tableView.reloadData()
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
        cell.noteTitle = notes[indexPath.row].content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(notes[indexPath.row])
    }
}
