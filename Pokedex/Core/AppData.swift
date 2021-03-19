//
//  AppData.swift
//  Pokedex
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import Foundation

class AppData {
    static let pokemonFile = "pokemons.json"
    
    var pokemon: Pokemon?
    var pokemons = [LocalPokemon]()
    
    let storage: Storable
    
    init(storage: Storable) {
        self.storage = storage
    }
    
    func newSpecies() -> Bool {
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
    
    func directory() -> Directory {
        if Configuration.uiTesting == true {
            return .caches
        }
        return .documents
    }
    
    func sortByOrder() {
        pokemons.sort(by: {
            $0.order < $1.order
        })
    }
}
