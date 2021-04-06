//
//  Generator.swift
//  Pokedex
//
//  Created by Ronan on 10/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import Foundation

struct Generator {
    static func nextIdentifier() -> Int {
        return Int.random(in: Constants.PokemonAPI.minIdentifier..<Constants.PokemonAPI.maxIdentifier)
    }
}
