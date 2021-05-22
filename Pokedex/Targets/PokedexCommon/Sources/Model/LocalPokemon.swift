//
//  Pokemon.swift
//  Pokedex
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import Foundation

public struct LocalPokemon: Codable {
    public let name: String
    public let weight: Int
    public let height: Int
    public let order: Int
    public let spriteUrlString: String?
    public let date: Date
    public let species: String
    public let baseExperience: Int
    public let types: [String]
}
