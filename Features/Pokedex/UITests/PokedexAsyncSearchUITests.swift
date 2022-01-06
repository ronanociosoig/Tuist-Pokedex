//
//  PokedexAsyncSearchUITests.swift
//  PokedexUITests
//
//  Created by ronan.ociosoig on 05/01/2022.
//  Copyright © 2022 Sonomos.com. All rights reserved.
//

import XCTest

class PokedexAsyncSearchUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments += ["UITesting", "AsyncTesting"]
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
