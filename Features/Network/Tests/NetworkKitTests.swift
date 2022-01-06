//
//  NetworkKitTests.swift
//  NetworkKitTests
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import XCTest
import Combine
@testable import NetworkKit

// swiftlint:disable all

class NetworkKitTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    
    func testEndpointReturnsData() {
        let expectation = self.expectation(description: "No results in response data")
        let pokemonIdentifier = 1
        let data = try! MockData.loadResponse()!
        let searchService = buildSearchService(identifier: pokemonIdentifier,
                                               data: data,
                                               statusCode: 200)
        
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
        let searchService = buildSearchService(identifier: pokemonIdentifier,
                                               data: Data("".utf8),
                                                          statusCode: 401)
        
        searchService.search(identifier: pokemonIdentifier)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    if let httpError = error as? HTTPError {
                        if httpError == HTTPError.notFoundResponse {
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
    
    func testEndpointReturnsDataAsync() async throws {
        let pokemonIdentifier = 1
        let data = try! MockData.loadResponse()!
        let searchService = buildSearchService(identifier: pokemonIdentifier,
                                               data: data,
                                               statusCode: 200)
        
        do {
            guard let responseData = try await searchService.search(identifier: pokemonIdentifier) else {
                XCTFail()
                return
            }

            XCTAssertEqual(data.count, responseData.count, "Data length in the response should be equal to the mock.")
            XCTAssertNotNil(responseData)
        } catch {
            XCTFail()
        }
    }
    
    func testEndpointReturnsErrorAsync() async throws {
        let pokemonIdentifier = 1
        let searchService = buildSearchService(identifier: pokemonIdentifier,
                                               data: Data("".utf8),
                                               statusCode: 401)
        
        do {
            let responseData = try await searchService.search(identifier: pokemonIdentifier)
            
            XCTAssertNil(responseData)
        } catch (let error) {
            print("Error returned is: \(error.localizedDescription)")
            XCTAssertEqual(error.localizedDescription, Constants.Translations.Error.notFound, "The error message returned should be the same as in the translation constants for Pokemon not found 401.")
        }
    }
    
    func buildSearchService(identifier: Int,
                            data: Data,
                            statusCode: Int) -> PokemonSearchService {
        let endpoint = PokemonSearchEndpoint.search(identifier: identifier)
        let url = endpoint.makeURL()
        let session = MockSessionFactory.make(url: url,
                                              data: data,
                                              statusCode: statusCode)
        
        return PokemonSearchService(session: session)
    }
}
