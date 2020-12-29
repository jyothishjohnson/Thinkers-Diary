//
//  FolderResponseDTO.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 27/11/20.
//

import Foundation

struct FolderResponseDTO : Hashable, Decodable {
    
    var id : String
    var name : String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: FolderResponseDTO, rhs: FolderResponseDTO) -> Bool {
        return lhs.id == rhs.id
    }
}
