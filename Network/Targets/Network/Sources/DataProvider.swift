//
//  DataProvider.swift
//  Network
//
//  Created by Ronan O Ciosig on 2/5/21.
//  Copyright © 2021 Sonomos.com. All rights reserved.
//

import Foundation
import NetworkKit
import os.log

class DataProvider {
    let networkService: PokemonSearchLoadingService
    static let maxIdentifier = 1000
    
    var notifier: Notifier?
    var pokemon: Pokemon?
    
    init(service: PokemonSearchLoadingService) {
        self.networkService = service
    }
    
    func search(identifier: Int) {
        networkService.search(identifier: identifier) { data, errorMessage in
            let queue = DispatchQueue.main
            
            if let errorMessage = errorMessage {
                if errorMessage == Constants.Translations.Error.statusCode404 {
                    os_log("Error message: %s", log: Log.network, type: .error, errorMessage)
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
                self.pokemon = try decoder.decode(Pokemon.self, from: data)
                self.notifier?.dataReceived(errorMessage: nil, on: queue)
                os_log("Success: %s", log: Log.network, type: .default, "Loaded")
            } catch {
                let errorMessage = "\(error)"
                os_log("Error: %s", log: Log.data, type: .error, errorMessage)
                self.notifier?.dataReceived(errorMessage: errorMessage, on: queue)
            }
        }
    }
}
