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
}
