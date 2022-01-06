//
//  PokemonSearchEndpoint.swift
//  NetworkKit
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import Foundation

public enum PokemonSearchEndpoint {
    case search(identifier: Int)
}

extension PokemonSearchEndpoint {
    
    public var baseURL: URL {
        // swiftlint:disable force_unwrapping
        return URL(string: Constants.Network.baseUrlPath)!
        // swiftlint:enable force_unwrapping
    }
    
    public var path: String {
        switch self {
        case .search(let identifier):
            return Constants.Network.searchPath + "/\(identifier)/"
        }
    }
    
    public var method: String {
        return "GET"
    }
    
    public var sampleData: Data {
        // swiftlint:disable force_try force_unwrapping
        return try! MockData.loadResponse()!
        // swiftlint:enable force_try force_unwrapping
    }

    public var headers: [String: String]? {
        return nil
    }
}
