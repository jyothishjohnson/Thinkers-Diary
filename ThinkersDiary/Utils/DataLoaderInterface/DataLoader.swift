//
//  DataLoader.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 03/02/21.
//

import Foundation

protocol DataLoader {
    
    associatedtype Items where Items : Decodable
    associatedtype E where E : Error
    
    func loadItems(completion : @escaping (Result<Items,E>) -> ())
}
