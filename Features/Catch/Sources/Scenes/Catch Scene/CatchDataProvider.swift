//
//  CatchDataProvider.swift
//  CatchUI
//
//  Created by Ronan on 01/07/21.
//  Copyright © 2021 Sonomos. All rights reserved.
//

import Foundation
import Common

public protocol CatchDataProvider {
    func pokemon() -> ScreenPokemon?
    func newSpecies() -> Bool
}

extension DataProvider: CatchDataProvider {
    public func pokemon() -> ScreenPokemon? {
        guard let foundPokemon = appData.pokemon else { return nil }
        return ScreenPokemon(name: foundPokemon.name,
                             weight: foundPokemon.weight,
                             height: foundPokemon.height,
                             iconPath: foundPokemon.sprites.frontDefault)
    }
}
