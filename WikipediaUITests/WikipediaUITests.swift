//
//  WikipediaUITests.swift
//  WikipediaUITests
//
//  Created by Bastien Cojan on 06/04/2017.
//  Copyright © 2017 Wikimedia Foundation. All rights reserved.
//

import XCTest

class WikipediaUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        setupSnapshot(app)
        
        app.launch()
        

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func test_smoketest () {
        // snapshot the home page
        snapshot("Home page")
        
        //search for steve jobs page
        app.navigationBars["Explore"].buttons["search"].tap()
        app.searchFields["Search Wikipedia"].typeText("steve jobs")
        
        // snapshot search page
        snapshot("Search")
        
        // wait for the results to load
        let existsPredicate = NSPredicate(format: "exists == true")
        let steveJobsLink = app.tables.links.element(boundBy: 0)
        expectation(for: existsPredicate, evaluatedWith: steveJobsLink, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        // tap on the first element
        steveJobsLink.tap()
        
        //screenshot steve jobs page
        snapshot("Steve Jobs Page")
        
        
        let fontSizeButton = app.toolbars.buttons["font size"]
        fontSizeButton.tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 2).children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.swipeLeft()
        fontSizeButton.tap()
        
        //screenshot steve jobs page
        snapshot("Steve Jobs Text size")

    }
}
