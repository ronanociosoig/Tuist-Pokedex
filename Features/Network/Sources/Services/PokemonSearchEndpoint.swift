//
//  PokemonSearchEndpoint.swift
//  NetworkKit
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import Foundation
import Moya

public enum PokemonSearchEndpoint {
    case search(identifier: Int)
}

extension PokemonSearchEndpoint: TargetType {
    // swiftlint:disable force_unwrapping
    public var baseURL: URL {
        return URL(string: Constants.Network.baseUrlPath)!
    }
    // swiftlint:enable force_unwrapping
    
    public var path: String {
        switch self {
        case .search(let identifier):
            return Constants.Network.searchPath + "/\(identifier)/"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        // swiftlint:disable force_try force_unwrapping
        return try! MockData.loadResponse()!
        // swiftlint:enable force_try force_unwrapping
    }
    
    public var task: Task {
        switch self {
        case .search:
            return .requestPlain
        }
    }
    
    public var headers: [String: String]? {
        return nil
    }
}
