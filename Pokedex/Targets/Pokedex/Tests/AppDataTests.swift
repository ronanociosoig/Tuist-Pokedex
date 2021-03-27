//
//  AppDataTests.swift
//  PokedexTests
//
//  Created by Ronan on 10/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

// swiftlint:disable all

import XCTest

@testable import Pokedex

class AppDataTests: XCTestCase {
    enum PokemonId: Int {
        case pokemon5
        case pokemon12
    }
    
    func testNewSpecies() {
        let appData = AppData(storage: FileStorage())
        let pokemon5 = loadPokemon(identifier: .pokemon5)
        let pokemon12 = loadPokemon(identifier: .pokemon12)
        
        appData.pokemon = pokemon5
        let localPokemon = PokemonParser.parse(pokemon: pokemon5)
        appData.pokemons.append(localPokemon)
        
        var newSpecies = appData.newSpecies()
        
        XCTAssertFalse(newSpecies)
        
        appData.pokemon = pokemon12
        
        newSpecies = appData.newSpecies()
        
        XCTAssertTrue(newSpecies)
    }
    
    func loadPokemon(identifier: PokemonId) -> Pokemon {
        let data: Data
        
        switch identifier {
        case .pokemon5:
            data = try! MockData.loadResponse()!
        case .pokemon12:
            data = try! MockData.loadOtherResponse()!
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let pokemon = try! decoder.decode(Pokemon.self, from: data)
        return pokemon
    }
    
    func testSortByOrder() {
        let appData = AppData(storage: FileStorage())
        let pokemon5 = loadPokemon(identifier: .pokemon5)
        let pokemon12 = loadPokemon(identifier: .pokemon12)
        let localPokemon5 = PokemonParser.parse(pokemon: pokemon5)
        let localPokemon12 = PokemonParser.parse(pokemon: pokemon12)
        appData.pokemons.append(localPokemon5)
        appData.pokemons.append(localPokemon12)
        
        appData.sortByOrder()
        
        guard let firstItem = appData.pokemons.first else {
            XCTFail("Failed to parse data")
            return
        }
        guard let lastItem = appData.pokemons.last else {
            XCTFail("Failed to parse data")
            return
        }
        
        XCTAssertTrue(firstItem.order < lastItem.order)
    }
}
