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
import Combine

protocol DataSearchProviding {
    func search(identifier: Int, networkService: SearchService)
    func pokemonName() -> String?
}

extension DataProvider: DataSearchProviding {
    public func search(identifier: Int, networkService: SearchService) {
        appData.pokemon = nil
        let queue = DispatchQueue.main
        
        searchCancellable = networkService.search(identifier: identifier)
            .receive(on: queue)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    let errorMessage = "\(error.localizedDescription)"
                    os_log("Error: %s", log: Log.data, type: .error, errorMessage)
                    self.notifier?.dataReceived(errorMessage: errorMessage, on: queue)
                case .finished:
                    print("All good")
                }
                
            }, receiveValue: { data in
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let pokemon = try decoder.decode(Pokemon.self, from: data)
                    self.appData.pokemon = pokemon
                    self.notifier?.dataReceived(errorMessage: nil, on: queue)
                    os_log("Success: %s", log: Log.network, type: .default, "Loaded")
                } catch {
                    let errorMessage = "\(error.localizedDescription)"
                    os_log("Error: %s", log: Log.data, type: .error, errorMessage)
                    self.notifier?.dataReceived(errorMessage: errorMessage, on: queue)
                }
            })
    }
    
    func pokemonName() -> String? {
        return appData.pokemon?.name
    }
}
