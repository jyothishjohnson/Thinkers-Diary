//
//  UserDefs.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 20/10/20.
//

import Foundation

extension UserDefaults {
    
    func setIsUserLoggedInStatus(_ status: Bool){
        self.setValue(status, forKey:  GlobalConstants.UserStatus.loginStatus)
    }
    
    func getIsUserLoggedInStatus() -> Bool{
        self.bool(forKey: GlobalConstants.UserStatus.loginStatus)
    }
}
