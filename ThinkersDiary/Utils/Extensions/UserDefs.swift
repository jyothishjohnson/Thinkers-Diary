//
//  UserDefs.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 20/10/20.
//

import Foundation

extension UserDefaults {
    
    //MARK: - current login status
    func setIsUserLoggedInStatus(_ status: Bool){
        self.setValue(status, forKey:  GlobalConstants.UserStatus.loginStatusKey)
    }
    
    func getIsUserLoggedInStatus() -> Bool{
        self.bool(forKey: GlobalConstants.UserStatus.loginStatusKey)
    }
    
    
    //MARK: - skipped Login status
    func setUserLoginSkippedStatus(_ status: Bool){
        self.setValue(status, forKey: GlobalConstants.UserStatus.loginSkippedKey)
    }
    
    func getUserLoginSkippedStatus() -> Bool{
        self.bool(forKey: GlobalConstants.UserStatus.loginSkippedKey)
    }
    
    
    //MARK: - Initial app usage
    func setIsInitialAppUsage(_ status: Int){
        self.setValue(status, forKey: GlobalConstants.AppStatus.isInitialUsageKey)
    }
    
    func getIsInitialAppUsage() -> Int{
        self.integer(forKey: GlobalConstants.AppStatus.isInitialUsageKey)
    }
    
    //MARK: - Network Status
    func setNetworkStatusisActive(_ status: Bool){
        self.setValue(status, forKey: GlobalConstants.NetworkStatus.isActive)
    }
    
    func getNetworkStatusisActive() -> Bool{
        self.bool(forKey: GlobalConstants.NetworkStatus.isActive)
    }
}
