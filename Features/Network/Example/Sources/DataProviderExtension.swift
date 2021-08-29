//
//  DataProviderExtension.swift
//  NetworkKitExample
//
//  Created by Ronan O Ciosig on 5/6/21.
//  Copyright © 2021 Sonomos. All rights reserved.
//

import Foundation
import NetworkKit
import os.log
import Common

protocol DataSearchProviding {
    func search(identifier: Int, networkService: SearchService)
    func pokemonName() -> String?
}

extension DataProvider: DataSearchProviding {
    func search(identifier: Int, networkService: SearchService) {
        appData.pokemon = nil
        
        networkService.search(identifier: identifier) { (data, errorMessage) in
            let queue = DispatchQueue.main
            
            if let errorMessage = errorMessage {
                if errorMessage == Constants.Translations.Error.statusCode404 {
                    self.notifier?.dataReceived(errorMessage: errorMessage, on: queue)
                    return
                }
                
                os_log("Error message: %s", log: Log.network, type: .error, errorMessage)
                self.notifier?.dataReceived(errorMessage: errorMessage, on: queue)
                return
            }
            
            guard let data = data else {
                os_log("Error message: %s", log: Log.network, type: .error, Constants.Translations.Error.noDataError)
                self.notifier?.dataReceived(errorMessage: Constants.Translations.Error.noDataError, on: queue)
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                self.appData.pokemon = pokemon
                self.notifier?.dataReceived(errorMessage: nil, on: queue)
                os_log("Success: %s", log: Log.network, type: .default, "Loaded")
            } catch {
                let errorMessage = "\(error)"
                os_log("Error: %s", log: Log.data, type: .error, errorMessage)
                self.notifier?.dataReceived(errorMessage: errorMessage, on: queue)
            }
        }
    }
    
    func pokemonName() -> String? {
        return appData.pokemon?.name
    }
}
