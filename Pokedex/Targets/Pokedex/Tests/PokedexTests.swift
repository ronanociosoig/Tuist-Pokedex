//
//  PokedexTests.swift
//  PokedexTests
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import XCTest

// swiftlint:disable all

@testable import Pokedex

class PokedexTests: XCTestCase {
    func testEndpointReturnsData() {
        
        let expectation = self.expectation(description: "No results in response data")
        
        let searchService = PokemonSearchService()
        
        searchService.search(identifier: 1) { (data, error) in
            if let error = error {
                print("Error: \(error)")
                XCTFail("Error in the server call")
                return
            }
            
            if let data = data {
                let length = data.count
                print("We have some data.: \(length)")
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testCanParsePokemon() {
        let data = try! MockData.loadResponse()
        
        XCTAssertNotNil(data)
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let pokemon = try decoder.decode(Pokemon.self, from: data!)
            
            XCTAssertNotNil(pokemon)
        } catch (let error) {
            XCTFail("Decoding error: \(error)")
        }

    }
}
