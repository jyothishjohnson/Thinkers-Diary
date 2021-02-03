//
//  FolderLoader.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 03/02/21.
//

import Foundation

struct FolderLoader<T : Decodable> : DataLoader {
    
    func loadItems(completion: @escaping (Result<T, NetworkManagerError>) -> ()) {
        
        let url = URL(string: "\(EP.ipBaseURL)\(EP.allUserFolders)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = NetworkMethods.GET.rawValue
        
        NetworkManager.shared.makeRequest(request, resultHandler: completion)
    }
    
    func addItem(item : NewFolder, completion : @escaping (Result<Folder, NetworkManagerError>) -> ()){
        
        let data = try? JSONEncoder().encode(item)
        
        let url = URL(string: "\(EP.ipBaseURL)\(EP.addNewFolder)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = NetworkMethods.POST.rawValue
        request.httpBody = data
        
        NetworkManager.shared.makeRequest(request, resultHandler: completion)
    }
    
    func deleteItem(item : DeleteFolder, completion : @escaping (Result<Int,NetworkManagerError>) -> ()){
        let data = try? JSONEncoder().encode(item)
        
        let url = URL(string: "\(EP.ipBaseURL)\(EP.deleteFolder)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = NetworkMethods.DELETE.rawValue
        request.httpBody = data
        
        NetworkManager.shared.makeRequest(request, resultHandler: completion)
    }
}
