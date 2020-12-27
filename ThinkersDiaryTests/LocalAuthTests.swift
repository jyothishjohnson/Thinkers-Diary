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
        
        XCTAssertEqual(LocalAuthValidator.validateUserName(userName: "jonsnow").1, true, LocalAuthValidator.validateUserName(userName: "jonsnow").0)
        
        XCTAssertEqual(LocalAuthValidator.validateUserName(userName: "jon").1, false, LocalAuthValidator.validateUserName(userName: "jon").0)
        
        XCTAssertEqual(LocalAuthValidator.validateUserName(userName: "jonsnowisfromamagicelalnadirnqwertttyyireo").1, false, LocalAuthValidator.validateUserName(userName: "jonsnowisfromamagicelalnadirnqwertttyyireo").0)
    }
}
