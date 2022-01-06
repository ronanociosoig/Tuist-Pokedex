//
//  DataProvider.swift
//  Common
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import Foundation
import os.log
import Combine

public class DataProvider: DataProviding {
    public let appData = AppData(storage: FileStorage())
    public var notifier: Notifier?
    public var searchCancellable: AnyCancellable?

    public init() {
        
    }
    
    public func start() {
        appData.load()
        appData.sortByOrder()
    }
    
    public func catchPokemon() {
        guard let pokemon = appData.pokemon else { return }
        let localPokemon = PokemonParser.parse(pokemon: pokemon)
        appData.pokemons.append(localPokemon)
        appData.sortByOrder()
        appData.save()
    }
    
    public func newSpecies() -> Bool {
        return appData.newSpecies()
    }
    
    public func pokemon(at index: Int) -> LocalPokemon {
        return appData.pokemons[index]
    }
}
