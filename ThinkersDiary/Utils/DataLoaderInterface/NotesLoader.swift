//
//  NotesLoader.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 04/02/21.
//

import Foundation

struct NotesLoader<Item : Decodable> : DataLoader {
    
    func loadItems(from folderId: String, completion: @escaping (Result<Item, NetworkManagerError>) -> ()) {
        
        let url = URL(string: "\(EP.ipBaseURL)\(EP.paginatedNotes)\(folderId)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = NetworkMethods.GET.rawValue
        
        NetworkManager.shared.makeRequest(request, resultHandler: completion)
    }
    
    func addItem(item note : UploadNote, completion : @escaping (Result<Note, NetworkManagerError>) -> ()){
        
        let data = try? JSONEncoder().encode(note)
        
        let url = URL(string: "\(EP.ipBaseURL)\(EP.addNewNote)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = NetworkMethods.POST.rawValue
        request.httpBody = data
        
        NetworkManager.shared.makeRequest(request, resultHandler: completion)
    }
    
    func deleteItem(item note : DeleteNote, completion : @escaping (Result<Int, NetworkManagerError>) -> ()){
        
        let data = try? JSONEncoder().encode(note)
        
        let url = URL(string: "\(EP.ipBaseURL)\(EP.deleteNote)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = NetworkMethods.DELETE.rawValue
        request.httpBody = data
        
        NetworkManager.shared.makeRequest(request, resultHandler: completion)
    }
}
