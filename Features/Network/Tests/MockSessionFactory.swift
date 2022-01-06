//
//  MockSessionFactory.swift
//  NetworkKitTests
//
//  Created by Ronan on 03/01/2022.
//  Copyright © 2022 Sonomos. All rights reserved.
//

import Foundation

struct MockSessionFactory {
    static func make(url: URL, data: Data, statusCode: Int) -> URLSession {
        
        guard let response = HTTPURLResponse(url: url,
                                       statusCode: statusCode,
                                       httpVersion: nil,
                                       headerFields: nil) else {
            return URLSession.shared   
        }
        
        let mockResponse = MockResponse(response: response, url: url, data: data)

        URLProtocolMock.testResponses = [url: mockResponse]
        
        // now setup a configuration to use our mock
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        
        // and create the URLSession form that
        return URLSession(configuration: config)
    }
}
