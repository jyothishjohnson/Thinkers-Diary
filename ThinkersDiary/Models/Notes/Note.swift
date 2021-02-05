//
//  Note.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 16/11/20.
//
import Foundation

struct Note: Hashable,Decodable {
    
    var id : String
    var name : String
    var content : Data?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct PaginatedNotes: Decodable {
    
    var items : [Note]?
}
