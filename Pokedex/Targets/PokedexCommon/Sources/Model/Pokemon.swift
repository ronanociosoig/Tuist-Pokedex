//
//  Pokemon.swift
//  Pokedex
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import Foundation

public struct Pokemon: Codable {
    let baseExperience: Int
    public let height: Int
    // swiftlint:disable identifier_name
    let id: Int
    // swiftlint:enable identifier_name
    public let name: String
    public let order: Int
    let species: Species
    public let sprites: Sprites
    public let types: [TypeElement]
    public let weight: Int
}

public struct Species: Codable {
    public let name: String
    public let url: String
}

public struct Sprites: Codable {
    let backDefault: String?
    let backFemale: String?
    let backShiny: String?
    let backShinyFemale: String?
    public let frontDefault: String?
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?
}

public struct TypeElement: Codable {
    let slot: Int
    public let type: Species
}
