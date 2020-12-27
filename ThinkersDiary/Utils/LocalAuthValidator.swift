//
//  LocalAuthValidator.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 26/12/20.
//

import Foundation

struct LocalAuthValidator {
    
    static func validateUserName(userName : String) -> (String,Bool) {
        
        if userName.count < 4 {
            return (LocalAuthError.userNameTooSmall.errorMessage, false)
        }else if userName.count > 20 {
            return (LocalAuthError.userNameTooLarge.errorMessage, false)
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
                return (LocalAuthError.invalidUserName.errorMessage, false)
            }
            return ("Success", true)
        }
    }
    
    static func validateUserPassword(password : String) -> (String,Bool) {
        
        if password.count < 4 {
            return (LocalAuthError.passwordTooSmall.errorMessage, false)
        }else if password.count > 24 {
            return (LocalAuthError.passwordTooLarge.errorMessage, false)
        }else {
            return ("Success", true)
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
