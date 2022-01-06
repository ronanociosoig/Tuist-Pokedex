//
//  PokemonParser.swift
//  Common
//
//  Created by Ronan on 10/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import Foundation

public struct PokemonParser {
    public static func parse(pokemon: Pokemon) -> LocalPokemon {
        let types = pokemon.types
        
        let typeNames = types.map {
            $0.type.name
        }
        
        return LocalPokemon(name: pokemon.name,
                                        weight: pokemon.weight,
                                        height: pokemon.height,
                                        order: pokemon.order,
                                        spriteUrlString: pokemon.sprites.frontDefault,
                                        date: Date(),
                                        species: pokemon.species.name, baseExperience: pokemon.baseExperience, types: typeNames)
    }
}
