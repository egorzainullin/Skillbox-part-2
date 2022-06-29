//
//  Task11UITests.swift
//  Task11UITests
//
//  Created by Егор Зайнуллин on 28.06.2022.
//

import XCTest

class Task11UITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLogin() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let loginTextField = app.textFields["Login"]
        loginTextField.tap()
        loginTextField.typeText("123")
        
        let passwordTextField = app.textFields["Password"]
        passwordTextField.tap()
        passwordTextField.typeText("45A67yh")
        
        app.buttons["Send"].tap()
        app.staticTexts["Email is incorrect"].tap()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPassword() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        let loginTextField = app.textFields["Login"]
        loginTextField.tap()
        loginTextField.typeText("abc@mail.ru")
        
        let passwordTextField = app.textFields["Password"]
        passwordTextField.tap()
        passwordTextField.typeText("password")
        
        app.buttons["Send"].tap()
        app.staticTexts["Password is incorrect"].tap()
        
    }
    
    func testButtonIsNotEnabled() throws {
        let app = XCUIApplication()
        app.launch()
        let button = app.buttons["Send"]
        XCTAssertFalse(button.isEnabled)
    }
}
