//
//  Pokemon.swift
//  Pokedex
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import Foundation

struct LocalPokemon: Codable {
    let name: String
    let weight: Int
    let height: Int
    let order: Int
    let spriteUrlString: String?
    let date: Date
    let species: String
    let baseExperience: Int
    let types: [String]
}
