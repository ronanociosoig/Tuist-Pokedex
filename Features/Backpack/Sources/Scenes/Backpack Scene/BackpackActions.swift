//
//  BackpackActions.swift
//  Pokedex
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import Common

public protocol BackpackActions {
    func selectItem(at index: Int)
}

extension Actions: BackpackActions {
    public func selectItem(at index: Int) {
        guard let dataProvider = dataProvider else { return }
        let pokemon = dataProvider.pokemon(at: index)
        coordinator.showPokemonDetailScene(pokemon: pokemon)
    }
}
