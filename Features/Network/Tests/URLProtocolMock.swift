//
//  URLProtocolMock.swift
//  NetworkKitTests
//
//  Created by Ronan on 02/01/2022.
//  Copyright © 2022 Sonomos. All rights reserved.
//

import Foundation

struct MockResponse {
    let response: URLResponse
    let url: URL
    let data: Data?
}

class URLProtocolMock: URLProtocol {
    // this dictionary maps URLs to mock responses containing data
    static var testResponses = [URL: MockResponse]()
    static var error: Error?

    // say we want to handle all types of request
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    // ignore this method; just send back what we were given
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let url = request.url {
            
            // if we have a valid URL with a response…
            if let response = URLProtocolMock.testResponses[url] {
                
                // …and if we have test data for that URL…
                if url.absoluteString == response.url.absoluteString, let data = response.data {
                    self.client?.urlProtocol(self, didLoad: data)
                }
                
                // …and we return our response if defined…
                self.client?.urlProtocol(self,
                                         didReceive: response.response,
                                         cacheStoragePolicy: .notAllowed)
            }
        }

        // …and we return our error if defined…
        if let error = URLProtocolMock.error {
            self.client?.urlProtocol(self, didFailWithError: error)
        }

        // mark that we've finished
        self.client?.urlProtocolDidFinishLoading(self)
    }

    // this method is required but doesn't need to do anything
    override func stopLoading() {
        
    }
}
