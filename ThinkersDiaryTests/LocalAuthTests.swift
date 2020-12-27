//
//  LocalAuthTests.swift
//  ThinkersDiaryTests
//
//  Created by jyothish.johnson on 26/12/20.
//

@testable import ThinkersDiary
import XCTest

class LocalAuthTests: XCTestCase {
    
    func testUserLocalAuth(){
        
        XCTAssertEqual(LocalAuthValidator.validateUserName(userName: "jonsnow").isValid, true, LocalAuthValidator.validateUserName(userName: "jonsnow").message)
        
        XCTAssertEqual(LocalAuthValidator.validateUserName(userName: "jon").isValid, false, LocalAuthValidator.validateUserName(userName: "jon").message)
        
        XCTAssertEqual(LocalAuthValidator.validateUserName(userName: "jonsnowisfromamagicelalnadirnqwertttyyireo").isValid, false, LocalAuthValidator.validateUserName(userName: "jonsnowisfromamagicelalnadirnqwertttyyireo").message)
    }
}
