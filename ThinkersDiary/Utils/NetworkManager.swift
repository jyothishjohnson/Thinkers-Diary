//
//  NetworkManager.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 16/11/20.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func makeRequest<T: Any>(_ request : URLRequest, resultHandler: @escaping (Result<T,NetworkManagerError>) -> Void){
        
        let urlTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                resultHandler(.failure(.UnknownError))
                return
            }
            
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                resultHandler(.failure(.ServerError))
                return
            }
            
            guard let data = data else {
                resultHandler(.failure(.NoData))
                return
            }
            
            guard let decodedData: T = self.decodedData(data) else {
                resultHandler(.failure(.DataDecodingError))
                return
            }
            
            resultHandler(.success(decodedData))
        }

        urlTask.resume()
    }
    
    private func decodedData<T: Any>(_ data: Data) -> T? {
          if T.self is String.Type {
              return String(data: data, encoding: .utf8) as? T
          } else {
              return try? JSONSerialization.jsonObject(with: data) as? T
          }
      }
}

enum NetworkManagerError: Error{
    
    case NoData
    case ServerError
    case Forbidden
    case DataDecodingError
    case UnknownError
}

enum NetworkMethods: String {
    
    case POST
    case GET
    case PUT
    case DELETE
}
