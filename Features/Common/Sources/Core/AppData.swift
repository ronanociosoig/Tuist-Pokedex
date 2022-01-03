//
//  AppData.swift
//  Common
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import Foundation

public class AppData {
    public static let pokemonFile = "pokemons.json"
    
    public var pokemon: Pokemon?
    public var pokemons = [LocalPokemon]()
    
    let storage: Storable
    
    public init(storage: Storable) {
        self.storage = storage
    }
    
    public func newSpecies() -> Bool {
        guard let pokemon = pokemon else { return false }
        
        if pokemons.isEmpty {
            return true
        }
        
        let foundSpecies = pokemons.filter {
            $0.species == pokemon.species.name
        }
        
        return foundSpecies.isEmpty
    }
    
    func load() {
        pokemons = storage.load(AppData.pokemonFile, from: directory(), as: [LocalPokemon].self) ?? [LocalPokemon]()
    }
    
    func save() {
        storage.save(pokemons, to: directory(), as: AppData.pokemonFile)
    }
    
    public func directory() -> Directory {
        if Configuration.uiTesting == true {
            return .caches
        }
        return .documents
    }
    
    public func sortByOrder() {
        pokemons.sort(by: {
            $0.order < $1.order
        })
    }
}
