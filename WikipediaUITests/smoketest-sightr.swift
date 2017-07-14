//
//  smoketest-sightr.swift
//  Wikipedia
//
//  Created by Bastien Cojan on 02/05/2017.
//  Copyright © 2017 Wikimedia Foundation. All rights reserved.
//

import Foundation
import XCTest

class WikipediaSmokeUITests: XCTestCase {
    var args: [String] = []
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        setupSnapshot(app)
        app.launchArguments = ["network_stubbing"] ;
        
        app.launch()
        
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
        
        //change text size
        app.toolbars.buttons["font size"].tap()
        app.children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 2).children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.swipeLeft()
        
        //screenshot steve jobs Text Size
        snapshot("Steve Jobs Text Size")
    }
}


