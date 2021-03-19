//
//  Server_401_Error_Test.swift
//  PokedexUITests
//
//  Created by Ronan on 14/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import XCTest

class Server_401_Error_Test: XCTestCase {

    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments += ["Error_401"]
        app.launch()
        
        print(XCUIApplication().debugDescription)
    }
    
    func testSearchPokemon() {
        let app = XCUIApplication()
        app.buttons["Ball"].tap()
        app.alerts["Error: 401"].buttons["OK"].tap()
    }
}
