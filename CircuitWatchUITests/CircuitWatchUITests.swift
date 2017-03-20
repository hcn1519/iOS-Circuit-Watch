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
    func testSnapshot() {

        let app = XCUIApplication()
        
        snapshot("1-Main")
        app.tables.cells.element(boundBy: 0).tap()
        
        snapshot("2-Circuit")
        let backBtn = app.navigationBars["CircuitWatch.CircuitVC"].children(matching: .button).element(boundBy: 1)
        backBtn.tap()
        
        let circuitwatchMainvcNavigationBar = app.navigationBars["CircuitWatch.MainVC"]
        
        circuitwatchMainvcNavigationBar.buttons.element(boundBy: 1).tap()
        
        
        snapshot("3-AddCircuit")
        
        let addBackBtn = app.navigationBars["CircuitWatch.AddCircuitVC"].children(matching: .button).element(boundBy: 1)
        addBackBtn.tap()
        
        let editBtn = app.navigationBars["CircuitWatch.MainVC"].buttons.element(boundBy: 0)
        editBtn.tap()
        snapshot("4-MainEdit")
        
        editBtn.tap()
        
    }
    
}
