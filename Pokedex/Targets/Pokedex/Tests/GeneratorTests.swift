//
//  GeneratorTests.swift
//  PokedexTests
//
//  Created by Ronan on 10/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import XCTest

// swiftlint:disable all

@testable import Pokedex
            
class GeneratorTests: XCTestCase {
    func testGenerator() {
        
        let max = 2000
        
        for _ in 0..<max {
            let identifier = Generator.nextIdentifier()
            
            XCTAssertTrue(identifier >= Constants.PokemonAPI.minIdentifier
                && identifier < Constants.PokemonAPI.maxIdentifier)
        }
        
    }
}
