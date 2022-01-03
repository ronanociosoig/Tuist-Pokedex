//
//  FileStorage.swift
//  Common
//
//  Created by Ronan on 23/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import Foundation

public enum Directory {
    case documents
    case caches
}

public protocol Storable {
    func fileExists(fileName: String, in directory: Directory) -> Bool
    func save<T: Encodable>(_ object: T, to directory: Directory, as fileName: String)
    func load<T: Decodable>(_ fileName: String, from directory: Directory, as type: T.Type) -> T?
    func remove(_ fileName: String, from directory: Directory)
}

public class FileStorage: Storable {
    public init() {
        
    }
    public func save<T>(_ object: T, to directory: Directory, as fileName: String) where T: Encodable {
        Storage.store(object, to: directoryAdaptor(directory: directory), as: fileName)
    }
    
    public func load<T>(_ fileName: String, from directory: Directory, as type: T.Type) -> T? where T: Decodable {
        if fileExists(fileName: fileName, in: directory) {
            return Storage.retrieve(fileName, from: directoryAdaptor(directory: directory), as: T.self)
        }
        
        return nil
    }
    
    public func fileExists(fileName: String, in directory: Directory) -> Bool {
        return Storage.fileExists(AppData.pokemonFile, in: directoryAdaptor(directory: directory))
    }
    
    public func remove(_ fileName: String, from directory: Directory) {
        Storage.remove(fileName, from: directoryAdaptor(directory: directory))
    }
    
    private func directoryAdaptor(directory: Directory) -> Storage.Directory {
        switch directory {
        case Directory.documents:
            return Storage.Directory.documents
        case Directory.caches:
            return Storage.Directory.caches
        }
    }
}
