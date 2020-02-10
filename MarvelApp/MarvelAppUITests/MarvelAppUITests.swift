//
//  MarvelAppUITests.swift
//  MarvelAppUITests
//
//  Created by Rodrigo Pacheco on 05/02/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import XCTest
import MarvelApp

class MarvelAppUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSamplingOfElements() {
        let app = XCUIApplication()
        app.launch()

        let collectionViewsQuery = XCUIApplication().collectionViews
        let cellsQuery = collectionViewsQuery.cells

        cellsQuery.otherElements.containing(.staticText, identifier:"A.I.M.").children(matching: .other).element.swipeUp()
  
        cellsQuery.otherElements.containing(.staticText, identifier:"Adam Destine").children(matching: .other).element.swipeUp()
        cellsQuery.otherElements.containing(.staticText, identifier:"Agent Zero").children(matching: .other).element.swipeUp()
        cellsQuery.otherElements.containing(.staticText, identifier:"Ajak").children(matching: .other).element.swipeUp()
                
        cellsQuery.otherElements.containing(.staticText, identifier:"Ajak").children(matching: .other).element.swipeUp()
        
        let predicate = NSPredicate(format: "exists == 1")
        let object = app.staticTexts["Alex Power"]
        expectation(for: predicate, evaluatedWith: object, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFirsCharacterDescription() {
        let app = XCUIApplication()
        app.launch()
        
        let collectionViewsQuery = XCUIApplication().collectionViews
        let cellsQuery = collectionViewsQuery.cells
        
        cellsQuery.otherElements.containing(.staticText, identifier:"A.I.M.").children(matching: .other).element.tap()
        
        collectionViewsQuery.staticTexts["AIM is a terrorist organization bent on destroying the world."].tap()
    }
    
    func testFirsCharacterComics() {
        let app = XCUIApplication()
        app.launch()
        
        let collectionViewsQuery = XCUIApplication().collectionViews
        let cellsQuery = collectionViewsQuery.cells
        
        cellsQuery.otherElements.containing(.staticText, identifier:"A.I.M.").children(matching: .other).element.tap()
        
        collectionViewsQuery.staticTexts["AIM is a terrorist organization bent on destroying the world."].tap()
                
        collectionViewsQuery.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.swipeUp()
        
        let element = collectionViewsQuery.children(matching: .cell).element(boundBy: 4).children(matching: .other).element
        element.swipeUp()
        element.swipeUp()
        element.swipeUp()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 7).children(matching: .other).element.swipeUp()
    }
    

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
