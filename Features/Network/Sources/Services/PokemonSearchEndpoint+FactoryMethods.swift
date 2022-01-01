//
//  PokemonSearchEndpoint+FactoryMethods.swift
//  NetworkKit
//
//  Created by ronan.ociosoig on 01/01/2022.
//  Copyright © 2022 Sonomos.com. All rights reserved.
//

import Foundation

extension PokemonSearchEndpoint {
    public func makeURL() -> URL {
        let urlString = baseURL.absoluteString + path
        guard let url = URL(string: urlString) else {
            fatalError("Failed to create URL for endpoint: \(urlString)")
        }
        return url
    }
    
    public func makeURLRequest() -> URLRequest {
        let url = makeURL()
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        return request
    }
}
