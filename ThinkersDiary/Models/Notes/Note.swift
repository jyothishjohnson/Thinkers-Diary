//
//  Note.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 16/11/20.
//

struct Note: Decodable {
    
    var id : String?
    var name : String?
    var content : String?
    
}

struct PaginatedNotes: Decodable {
    
    var items : [Note]?
}
