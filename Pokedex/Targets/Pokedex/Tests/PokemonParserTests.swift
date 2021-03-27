//
//  PokemonParserTests.swift
//  PokedexTests
//
//  Created by Ronan on 10/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import XCTest

// swiftlint:disable all

@testable import Pokedex

class PokemonParserTests: XCTestCase {
    func testParsing() {
        let data = try! MockData.loadResponse()
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let pokemon = try! decoder.decode(Pokemon.self, from: data!)
        
        let localPokemon = PokemonParser.parse(pokemon: pokemon)
        
        XCTAssertNotNil(localPokemon)
        XCTAssertEqual(pokemon.name, localPokemon.name)
        XCTAssertEqual(pokemon.height, localPokemon.height)
        XCTAssertEqual(pokemon.weight, localPokemon.weight)
        XCTAssertEqual(pokemon.order, localPokemon.order)
        XCTAssertEqual(pokemon.baseExperience, localPokemon.baseExperience)
        
        let speciesName = pokemon.species.name
        
        XCTAssertEqual(speciesName, localPokemon.species)
        XCTAssertEqual(pokemon.sprites.frontDefault, localPokemon.spriteUrlString)
        
        let types = pokemon.types
        
        let typeNames = types.map {
            $0.type.name
        }
        
        XCTAssertEqual(typeNames, localPokemon.types)
    }
}
