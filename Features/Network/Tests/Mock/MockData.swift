//
//  MockData.swift
//  NetworkKit
//
//  Created by Ronan on 23/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

// swiftlint:disable all

class MockData {
    static let fileType = "json"
    static let fileReadError = "File not readable"
    static let fileNotFoundError = "File not found"
    
    static func load(name: String) throws -> Data? {
        let bundle = Bundle.init(for: MockData.self)
        
        if let path = bundle.path(forResource: name, ofType: fileType) {
            let fileUrl = URL.init(fileURLWithPath: path)
            do {
                let data = try Data.init(contentsOf: fileUrl)
                return data
            } catch {
                let error = fileReadError as! Error
                throw error
            }
        } else {
            let error = fileNotFoundError as! Error
            throw error
        }
    }
    
    static func loadNoResultsResponse() throws -> Data? {
        return try load(name: "noResultsServerResponse" )
    }
    
    static func loadResponse() throws -> Data? {
        return try load(name: "Pokemon5")
    }
    
    static func loadOtherResponse() throws -> Data? {
        return try load(name: "Pokemon12")
    }
}
