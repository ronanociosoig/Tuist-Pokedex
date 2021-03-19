//
//  Wefox_PokedexUITests.swift
//  PokedexUITests
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import XCTest

class Wefox_PokedexUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments += ["UITesting"]
        app.launch()
        
        print(XCUIApplication().debugDescription)
    }
    
    func testSearchPokemon() {
        let ballButton = app.buttons["Ball"]
        ballButton.tap()
        app.alerts["Do you want to leave it or catch it?"].buttons["Catch it!"].tap()
        ballButton.tap()
        app.buttons["Backpack"].tap()
        app.collectionViews.cells.otherElements.containing(.staticText, identifier: "Charmeleon").element.tap()
        app.navigationBars["Charmeleon"].buttons["Backpack"].tap()
        app.navigationBars["Backpack"].buttons["Close"].tap()
    }

}
