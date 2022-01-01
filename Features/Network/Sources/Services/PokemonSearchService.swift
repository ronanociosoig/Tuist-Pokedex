//
//  PokemonSearchService.swift
//  NetworkKit
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import Foundation
import Combine

public protocol SearchService: AnyObject {
    func search(identifier: Int) -> AnyPublisher<Data, Error>
}

public class PokemonSearchService: SearchService {
    
    public init() {
        
    }
    
    public func search(identifier: Int) -> AnyPublisher<Data, Error> {
        let endpoint = PokemonSearchEndpoint.search(identifier: identifier)
        return performRequest(urlRequest: endpoint.makeURLRequest())
    }
    
    public func performRequest(urlRequest: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw HTTPError.invalidResponse
                }
                guard (200 ..< 300).contains(httpResponse.statusCode) else {
                    throw HTTPError.invalidResponse
                }
                return data
            }
            .eraseToAnyPublisher()
    }
}

public enum HTTPError: Equatable {
    case statusCode(Int)
    case invalidResponse
}

extension HTTPError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return NSLocalizedString("Error: 401", comment: "401")
        case .statusCode(let int):
            return String(int)
        }
    }
}
