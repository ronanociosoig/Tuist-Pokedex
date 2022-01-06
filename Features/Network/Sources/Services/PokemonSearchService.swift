//
//  PokemonSearchService.swift
//  NetworkKit
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import Foundation
import Combine

public struct HttpStatusCode {
    public struct Informational {
        static let range = 100..<200
    }
    
    public struct Success {
        static let range = 200..<300
    }
    
    public struct Redirection {
        static let range = 300..<400
    }
    
    public struct ClientError {
        static let range = 400..<500
        static let badRequest = 400
        static let notFoundError = 401
    }
    
    public struct ServerError {
        static let range = 500..<600
    }
}

public protocol SearchService: AnyObject {
    func search(identifier: Int) -> AnyPublisher<Data, Error>
    func search(identifier: Int) async throws -> Data?
    func performRequest(urlRequest: URLRequest) -> AnyPublisher<Data, Error>
    func performRequest(urlRequest: URLRequest) async throws -> Data?
}

public class PokemonSearchService: SearchService {
    let session: URLSession
    
    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    public func search(identifier: Int) -> AnyPublisher<Data, Error> {
        if Configuration.searchErrorTesting {
            return Fail(error: HTTPError.notFoundResponse)
                .eraseToAnyPublisher()
        } else if Configuration.uiTesting {
            return Just(loadMockData())
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
        }
        
        let endpoint = PokemonSearchEndpoint.search(identifier: identifier)
        return performRequest(urlRequest: endpoint.makeURLRequest())
    }
    
    public func performRequest(urlRequest: URLRequest) -> AnyPublisher<Data, Error> {
        return session.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw HTTPError
                        .invalidResponse(HttpStatusCode.ClientError.badRequest)
                }
                guard (HttpStatusCode.Success.range).contains(httpResponse.statusCode) else {
                    if httpResponse.statusCode == HttpStatusCode.ClientError.notFoundError {
                        throw HTTPError.notFoundResponse
                    } else {
                        throw HTTPError.invalidResponse(httpResponse.statusCode)
                    }
                }
                return data
            }
            .eraseToAnyPublisher()
    }
    
    public func search(identifier: Int) async throws -> Data? {
        if Configuration.searchErrorTesting {
            throw HTTPError.notFoundResponse
        } else if Configuration.uiTesting {
            return loadMockData()
        }
        
        let endpoint = PokemonSearchEndpoint.search(identifier: identifier)
        return try await performRequest(urlRequest: endpoint.makeURLRequest())
    }
    
    public func performRequest(urlRequest: URLRequest) async throws -> Data? {
        let (data, response) = try await session.data(for: urlRequest, delegate: nil)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw HTTPError.invalidResponse(HttpStatusCode.ClientError.badRequest)
        }
        
        let statusCode = httpResponse.statusCode
        
        guard (HttpStatusCode.Success.range).contains(statusCode) else {
            if statusCode == HttpStatusCode.ClientError.notFoundError {
                throw HTTPError.notFoundResponse
            } else {
                throw HTTPError.invalidResponse(statusCode)
            }
        }

        return data
    }
    
    private func loadMockData() -> Data {
        // swiftlint:disable force_try force_unwrapping
        return try! MockData.loadResponse()!
        // swiftlint:enable force_try force_unwrapping
    }
}

public enum HTTPError: Equatable {
    case statusCode(Int)
    case invalidResponse(Int)
    case notFoundResponse
}

extension HTTPError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidResponse(let int):
            let statusCode = String(int)
            return NSLocalizedString("Error: \(statusCode)", comment: statusCode)
        case .notFoundResponse:
            return NSLocalizedString(Constants.Translations.Error.notFound, comment: "401")
        case .statusCode(let int):
            return String(int)
        }
    }
}
