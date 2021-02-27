//
//  NetworkManager.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 16/11/20.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private var urlSession : URLSession!
    
    private init(){
        
        urlSession = configureURLSession()
    }
    
    func makeRequest<T: Decodable>(_ request : URLRequest, resultHandler: @escaping (Result<T,NetworkManagerError>) -> Void){
        
        var urlRequest = request
        urlRequest.cachePolicy = .reloadRevalidatingCacheData
        if urlRequest.httpBody != nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        let urlTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
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
    
    private func decodedData<T: Decodable>(_ data: Data) -> T?{
        
          if T.self is String.Type {
              return String(data: data, encoding: .utf8) as? T
          } else {
            return try? JSONDecoder().decode(T.self, from: data)
          }
    }
    
    private func configureURLSession() -> URLSession {
        
        let cache = URLCache()
        let config = URLSessionConfiguration.default
        config.urlCache = cache
        config.requestCachePolicy = .reloadRevalidatingCacheData
        return URLSession(configuration: config)
    }
}

enum NetworkManagerError: String, Error{
    
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
