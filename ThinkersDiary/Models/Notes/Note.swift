//
//  Note.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 16/11/20.
//

struct Note: Hashable,Decodable {
    
    var id : String
    var name : String
    var content : String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct PaginatedNotes: Decodable {
    
    var items : [Note]?
}
