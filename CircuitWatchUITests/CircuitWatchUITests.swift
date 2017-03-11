//
//  CircuitWatchUITests.swift
//  CircuitWatchUITests
//
//  Created by 홍창남 on 2017. 3. 10..
//  Copyright © 2017년 홍창남. All rights reserved.
//

import XCTest

class CircuitWatchUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
//        XCUIApplication().launch()

        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
//    func testScreenShots() {
//        let app = XCUIApplication()
//        let masterNavigationBar = app.navigationBars.element(boundBy: 0)
//        let addButton = masterNavigationBar.buttons.element(boundBy: 2)
//        addButton.tap()
//        addButton.tap()
//        
//        let tablesQuery = app.tables
//        tablesQuery.cells.element(boundBy: 0).tap()
//        app.navigationBars.element(boundBy: 0).buttons.element(boundBy: 0).tap()
//        masterNavigationBar.buttons.element(boundBy: 0).tap()
//        let cell = tablesQuery.cells.element(boundBy: 0)
//        cell.buttons.element(boundBy: 0).tap()
//        cell.buttons.element(boundBy: 1).tap()
//        masterNavigationBar.buttons.element(boundBy: 0).tap()
//    }
    
}
