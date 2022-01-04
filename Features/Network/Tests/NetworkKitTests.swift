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
        
        // Define the URL and mock data in a dictionary property of the protocol mock
        let endpoint = PokemonSearchEndpoint.search(identifier: pokemonIdentifier)
        let url = endpoint.makeURL()
        let data = try! MockData.loadResponse()!
        let session = MockSessionFactory.make(url: url,
                                              data: data,
                                              statusCode: 200)
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
    
    func testEndpointReturns401Error() {
        let expectation = self.expectation(description: "No results in response data")
        let pokemonIdentifier = 900
        let endpoint = PokemonSearchEndpoint.search(identifier: pokemonIdentifier)
        let url = endpoint.makeURL()
        let session = MockSessionFactory.make(url: url,
                                              data: Data("".utf8),
                                              statusCode: 401)

        let searchService = PokemonSearchService(session: session)

        searchService.search(identifier: pokemonIdentifier)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    if let httpError = error as? HTTPError {
                        if httpError == HTTPError.invalidResponse {
                            expectation.fulfill()
                        } else {
                            XCTFail("Should return HTTPError.invalidResponse")
                        }
                    }
                case .finished:
                    XCTFail("Should return HTTPError.invalidResponse")
                }
            }, receiveValue: { data in
                let response = String(data: data, encoding: .utf8)
                print("Response:\(String(describing: response))")
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 6, handler: nil)
    }
}
