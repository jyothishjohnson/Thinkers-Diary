//
//  LocalAuthValidator.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 26/12/20.
//

import Foundation

struct LocalAuthValidator {
    
    static func validateUserName(userName : String) -> Bool {
        
        if userName.count < 4 {
            return false
        }else if userName.count > 20 {
            return false
        }else {
            let invertedAlphaNumericSet = Set(arrayLiteral: CharacterSet.alphanumerics.inverted)
            var flag = false
            for char in Array(userName){
                if invertedAlphaNumericSet.contains(CharacterSet(charactersIn: "\(char)")) {
                    flag = true
                    break
                }
            }
            if flag {
                return false
            }
            return true
        }
    }
    
    static func validateUserPassword(password : String) -> Bool{
        
        if password.count < 4 {
            return false
        }else if password.count > 24 {
            return false
        }else {
            return true
        }
    }
}

enum LocalAuthError {
    
    case userNameTooSmall
    case invalidUserName
    case userNameTooLarge
    case passwordTooSmall
    case passwordTooLarge
    
    var errorMessage : String {
        switch self {
        
        case .userNameTooSmall:
            return "Username is too small"
        case .invalidUserName:
            return "Invalid username"
        case .userNameTooLarge:
            return "Username too large"
        case .passwordTooSmall:
            return "Password too small"
        case .passwordTooLarge:
            return "Password too large"
        }
    }
}
