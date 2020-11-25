//
//  Constants.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 20/10/20.
//

import Foundation

struct GlobalConstants {
    
    struct EndPoints {
        static let localBaseURL = "http://localhost:8080"
        static let ipBaseURL = "http://192.168.43.228:8080"
        
        static let userEndPoint = "/user"
        static let notesEndpoint = "/notes"
        static let noteEndpoint = "/note"
        
        static let addNewNote = "\(userEndPoint)\(noteEndpoint)/new"
        static let deleteNote = "\(userEndPoint)\(noteEndpoint)/delete"
        static let paginatedNotes = "\(userEndPoint)\(notesEndpoint)"
        static let allUserNotes = "\(userEndPoint)\(notesEndpoint)/all"
    }
    
    
    struct NotesVC {
        
        struct NotesListCell {
            
            static let id = "NotesListCell"
        }
    }
    
    struct Welcome {
        
        static let welcomeString = """
        Hello Again!
        Welcome
        back
        """
        
        static let firstTimeString =  """
        Hi there!
        First time here?
        """
    }
    
    struct AppStatus {
        
        static let isInitialUsageKey = "INITIAL_APP_USAGE"
    }
    
    struct UserStatus {
        
        static let loginStatusKey = "USER_LOGIN_STATUS"
        
        static let loginSkippedKey = "USER_LOGIN_SKIPPED"
    }
}
