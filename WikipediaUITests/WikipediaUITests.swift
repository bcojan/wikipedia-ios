//
//  WikipediaUITests.swift
//  WikipediaUITests
//
//  Created by Bastien Cojan on 06/04/2017.
//  Copyright © 2017 Wikimedia Foundation. All rights reserved.
//

import XCTest

class WikipediaUITests: XCTestCase {
    var args: [String] = []
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
//        let app = XCUIApplication()

        app.launchArguments = [
            "-inUITest",
            "-AppleLanguages",
            "(fr)",
            "-AppleLocale",
            "fr-FR"
        ]

        print("bastien")
        print(app.launchArguments)
//        setupSnapshot(app)
        print("bastien")
        print(app.launchArguments)
        args = app.launchArguments
        
        app.launch()
        

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func run (dic: [String:String]) {

        
        if app.buttons[dic["getstarted"]!].exists {
            app.buttons[dic["getstarted"]!].tap()
            app.buttons[dic["continue"]!].tap()
            app.buttons[dic["done"]!].tap()
        }
        if app.alerts[dic["alert"]!].exists {
            app.alerts[dic["alert"]!].buttons["Allow"].tap()
        }
        
        if app.navigationBars[dic["back"]!].exists {
            app.navigationBars[dic["back"]!].buttons[dic["explore"]!].tap()
        }
        
        snapshot("Home page")
        
        app.navigationBars[dic["explore"]!].buttons["search"].tap()
        
        app.searchFields[dic["search"]!].typeText("steve jobs")
        
        
        
        let tablesQuery = app.tables
        
        let steveJobsLink = tablesQuery.links
        let countPredicate = NSPredicate(format: "count>10 ")
        
        let searchResultExp = expectation(for: countPredicate, evaluatedWith: steveJobsLink, handler: nil)
        XCTWaiter().wait(for: [searchResultExp], timeout: 5)
        
        snapshot("Search")
        
        tablesQuery.links.element(boundBy: 0).tap()
        
        let webView = app.webViews.element(boundBy: 0)
        let hittablePredicate = NSPredicate(format: "isHittable == true")
        let steveJobsLoadedExpect = expectation(for: hittablePredicate, evaluatedWith: webView, handler: nil)
        XCTWaiter().wait(for: [steveJobsLoadedExpect], timeout: 10)
        
        snapshot("Steve Jobs Page")

    }
    
    
    
    func testExample() {
        
        let dic_fr = [
            "getstarted":"COMMENCER",
            "continue":"CONTINUER",
            "done":"TERMINÉ",
            "alert":"Allow “Wikipedia” to access your location while you use the app?",
            "back":"Wikipédia, revenir à Explorer",
            "explore":"Explorer",
            "search":"Rechercher dans Wikipédia"
        ]
        
        let dic_en = [
            "getstarted":"GET STARTED",
            "continue":"CONTINUE",
            "done":"DONE",
            "alert":"Allow “Wikipedia” to access your location while you use the app?",
            "back":"Wikipedia, return to Explore",
            "explore":"Explore",
            "search":"Search Wikipedia"
        ]
        
        let dic_de = [
            "getstarted":"ANFANGEN",
            "continue":"FORTFAHREN",
            "done":"FERTIG",
            "alert":"Allow “Wikipedia” to access your location while you use the app?",
            "back":"Wikipedia, return to Explore",
            "explore":"Entdecken",
            "search":"Wikipedia, zurück zu Entdecken"
        ]
        
        let locales = args.filter { (locale) -> Bool in
            return locale.contains("de-DE")
            || locale.contains("en-US")
            || locale.contains("fr-FR")
        }
        print(args)
        let locale = locales.first
        print(locale)

        if let locale = locale {
            switch locale {
            case locale where locale.contains("de-DE"):
                run(dic:dic_de)
                break;
            case locale where locale.contains("fr-FR"):
                run(dic:dic_fr)
                break;
            case locale where locale.contains("en-US"):
                run(dic:dic_en)
                break;
            default:
                break
            }
            
        }
    }
    
}
