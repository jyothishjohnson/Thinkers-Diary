//
//  Constants.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 20/10/20.
//

import Foundation

struct GlobalConstants {
    
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
