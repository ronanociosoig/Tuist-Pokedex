//
//  DataProviderExtension.swift
//  PokedexCommon
//
//  Created by Ronan O Ciosig on 5/6/21.
//  Copyright © 2021 Sonomos.com. All rights reserved.
//

import Foundation
import NetworkKit
import os.log
import Common
import Combine

public protocol DataSearchProviding {
    func search(identifier: Int, networkService: SearchService, queue: DispatchQueue)
}

extension DataProvider: DataSearchProviding {
    public func search(identifier: Int,
                       networkService: SearchService,
                       queue: DispatchQueue = DispatchQueue.main) {
        appData.pokemon = nil
        
        if Configuration.asyncTesting {
            Task {
                do {
                    guard let data = try await networkService.search(identifier: identifier) else {
                        show(errorMessage: Constants.Translations.Error.asyncError, on: queue)
                        return
                    }
                    
                    decode(data: data, on: queue)
                } catch {
                    show(errorMessage: Constants.Translations.Error.asyncError, on: queue)
                }
            }
            return
        }
        
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
                
            }, receiveValue: { [weak self] data in
                self?.decode(data: data, on: queue)
            })
    }
    
    func decode(data: Data, on queue: DispatchQueue) {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let pokemon = try decoder.decode(Pokemon.self, from: data)
            self.appData.pokemon = pokemon
            self.notifier?.dataReceived(errorMessage: nil, on: queue)
            os_log("Success: %s", log: Log.network, type: .default, "Loaded")
        } catch {
            let errorMessage = "\(error.localizedDescription)"
            show(errorMessage: errorMessage, on: queue)
        }
    }
    
    func show(errorMessage: String, on queue: DispatchQueue) {
        os_log("Error: %s", log: Log.data, type: .error, errorMessage)
        self.notifier?.dataReceived(errorMessage: errorMessage, on: queue)
    }
}
