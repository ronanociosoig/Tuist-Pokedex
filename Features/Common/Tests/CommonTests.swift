//
//  CommonUnitTests.swift
//  CommonTests
//
//  Created by Ronan.
//  Copyright © 2021. All rights reserved.
//

@testable import Common

import XCTest

class CommonTests: XCTestCase {
    func testNextIdentifierGenerator() {
        // Given
        
        // When
        let identifier = Generator.nextIdentifier()
        // Then
        XCTAssertTrue(identifier < Constants.PokemonAPI.maxIdentifier)
    }
}
