//
//  BackpackDataProvider.swift
//  Pokedex
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import Common

public protocol BackpackDataProvider {
    func pokemons() -> [LocalPokemon]
}

extension DataProvider: BackpackDataProvider {
    public func pokemons() -> [LocalPokemon] {
        return appData.pokemons
    }
}
