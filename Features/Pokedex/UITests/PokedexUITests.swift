//
//  PokedexUITests.swift
//  PokedexUITests
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import XCTest

class PokedexUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments += ["UITesting"]
        app.launch()
        
        print(XCUIApplication().debugDescription)
    }
    
    func testSearchPokemon() {
        app.buttons["Ball"].tap()
        app.alerts["Do you want to leave it or catch it?"].buttons["Catch it!"].tap()
        app.buttons["Catch"].tap()
        app.buttons["Backpack"].tap()
        app.collectionViews.cells.otherElements.containing(.staticText, identifier: "Charmeleon").element.tap()
        app.navigationBars["Charmeleon"].buttons["Backpack"].tap()
        
        let closeButton = app.navigationBars["Backpack"].buttons["Close"]
        XCTAssertTrue(closeButton.waitForExistence(timeout: 1))
        closeButton.tap()
    }

}
