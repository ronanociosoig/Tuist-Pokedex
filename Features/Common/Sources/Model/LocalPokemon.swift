//
//  Pokemon.swift
//  Common
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
    
    public init(name: String,
                weight: Int,
                height: Int,
                order: Int,
                spriteUrlString: String?,
                date: Date,
                species: String,
                baseExperience: Int,
                types: [String]) {
        self.name = name
        self.weight = weight
        self.height = height
        self.order = order
        self.spriteUrlString = spriteUrlString
        self.date = date
        self.species = species
        self.baseExperience = baseExperience
        self.types = types
    }
}
