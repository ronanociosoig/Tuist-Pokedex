//
//  MockDataFactory.swift
//  Backpack
//
//  Created by Ronan O Ciosig on 19/6/21.
//  Copyright © 2021 Sonomos.com. All rights reserved.
//

import Foundation
import Common

struct MockDataFactory {
    static func makePokemons() -> [LocalPokemon] {
        
        let pokemon1 = LocalPokemon(name: "cascoon",
                                    weight: 115,
                                    height: 7,
                                    order: 350,
                                    spriteUrlString: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/268.png",
                                    date: Date(),
                                    species: "cascoon",
                                    baseExperience: 72,
                                    types: ["bug"])
        let pokemon2 = LocalPokemon(name: "cranidos",
                                    weight: 315,
                                    height: 9,
                                    order: 519,
                                    spriteUrlString: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/408.png",
                                    date: Date(),
                                    species: "cranidos",
                                    baseExperience: 70,
                                    types: ["rock"])
        
        return [pokemon1, pokemon2]
    }
}
