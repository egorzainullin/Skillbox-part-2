//
//  Task11Tests.swift
//  Task11Tests
//
//  Created by Егор Зайнуллин on 28.06.2022.
//

import XCTest
@testable import Task11

class Task11Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test() throws {
        XCTAssertTrue(Checker.isValidEmail("123@mail.ru"))
        XCTAssertTrue(Checker.isValidEmail("3_5@gmail.com"))
        XCTAssertFalse(Checker.isValidEmail("12"))
        XCTAssertFalse(Checker.isValidEmail("@mail.ru"))
        
        XCTAssertTrue(Checker.isValidPassword("123Abc"))
        XCTAssertTrue(Checker.isValidPassword("aBc123"))
        XCTAssertFalse(Checker.isValidPassword("12"))
        XCTAssertFalse(Checker.isValidPassword("12a3"))
    }
}
