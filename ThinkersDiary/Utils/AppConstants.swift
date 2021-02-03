//
//  Constants.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 20/10/20.
//  Github PAT test

import Foundation

struct GlobalConstants {
    
    struct EndPoints {
        static let localBaseURL = "http://localhost:8080"
        static let ipBaseURL = "http://192.168.29.228:8080"
        
        static let userEndPoint = "/user"
        static let notesEndpoint = "/notes"
        static let noteEndpoint = "/note"
        static let folderEndpoint = "/folder"
        static let foldersEndpoint = "/folders"
        
        static let addNewNote = "\(userEndPoint)\(noteEndpoint)/new"
        static let deleteNote = "\(userEndPoint)\(noteEndpoint)/delete"
        static let updateNoteDrawing = "\(userEndPoint)\(noteEndpoint)/updateDrawing"
        static let paginatedNotes = "\(userEndPoint)\(notesEndpoint)/"
        static let allUserNotes = "\(userEndPoint)\(notesEndpoint)/all"
        static let allUserFolders = "\(userEndPoint)\(foldersEndpoint)/all"
        static let addNewFolder = "\(userEndPoint)\(folderEndpoint)/new"
        static let deleteFolder = "\(userEndPoint)\(folderEndpoint)/delete"
    }
    
    
    struct NotesVC {
        
        struct NotesListCell {
            
            static let id = "NotesListCell"
        }
        
        struct FolderListCell {
            static let id = "FolderListCell"
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
    
    struct NetworkStatus {
        
        static let isActive = "NETWORK_IS_ACTIVE"
    }
}
