//
//  Pokemon.swift
//  Wefox Pokedex
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let baseExperience: Int
    let height: Int
    // swiftlint:disable identifier_name
    let id: Int
    // swiftlint:enable identifier_name
    let name: String
    let order: Int
    let species: Species
    let sprites: Sprites
    let types: [TypeElement]
    let weight: Int
}

struct Species: Codable {
    let name: String
    let url: String
}

struct Sprites: Codable {
    let backDefault: String?
    let backFemale: String?
    let backShiny: String?
    let backShinyFemale: String?
    let frontDefault: String?
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?
}

struct TypeElement: Codable {
    let slot: Int
    let type: Species
}
