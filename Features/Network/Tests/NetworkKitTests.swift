//
//  NetworkKitTests.swift
//  NetworkKitTests
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import XCTest
import Combine
import NetworkKit

// swiftlint:disable all

class NetworkKitTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    
    func testEndpointReturnsData() {
        let expectation = self.expectation(description: "No results in response data")
        let pokemonIdentifier = 1
        let endpoint = PokemonSearchEndpoint.search(identifier: pokemonIdentifier)
        let url = endpoint.makeURL()
        let data = try! MockData.loadResponse()!
        URLProtocolMock.testURLs = [url: data]

        // now set up a configuration to use our mock
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]

        // and create the URLSession from that
        let session = URLSession(configuration: config)
        
        let searchService = PokemonSearchService(session: session)

        searchService.search(identifier: pokemonIdentifier)
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
        
        waitForExpectations(timeout: 6, handler: nil)
    }
}

