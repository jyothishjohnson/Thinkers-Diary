//
//  LocalAuthTests.swift
//  ThinkersDiaryTests
//
//  Created by jyothish.johnson on 26/12/20.
//

@testable import ThinkersDiary
import XCTest

class LocalAuthTests: XCTestCase {
    
    func testUserUserName(){
        
        XCTAssertEqual(LocalAuthValidator.validateUserName(userName: "jonsnow"), true)
        
        XCTAssertEqual(LocalAuthValidator.validateUserName(userName: "jon"), false)
        
        XCTAssertEqual(LocalAuthValidator.validateUserName(userName: "jonsnowisfromamagicelalnadirnqwertttyyireo"), false)
    }
    
    func testUserPassword(){
        
        XCTAssertEqual(LocalAuthValidator.validateUserPassword(password: "123"), false)
        
        XCTAssertEqual(LocalAuthValidator.validateUserPassword(password: "password"), true)
        
        XCTAssertEqual(LocalAuthValidator.validateUserPassword(password: "jonsnowisfromamagicelalnadirnqwertttyyireo"), false)

    }
}
