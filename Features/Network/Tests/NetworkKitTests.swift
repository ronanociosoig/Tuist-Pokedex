//
//  NetworkKitTests.swift
//  NetworkKitTests
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import XCTest
import NetworkKit
import Combine

// swiftlint:disable all

class NetworkKitTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    
    func testEndpointReturnsData() {
        let expectation = self.expectation(description: "No results in response data")
        
        let searchService = PokemonSearchService()

        searchService.search(identifier: 1)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                    XCTFail("Error in the server call")
                case .finished:
                    print("All good")
                }
            }, receiveValue: { data in
                let length = data.count
                let response = String(data: data, encoding: .utf8)
                print("Response:\(String(describing: response))")
                print("We have some data.: \(length)")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
