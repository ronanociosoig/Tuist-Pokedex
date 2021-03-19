//
//  CatchActions.swift
//  Pokedex
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

protocol CatchActions {
    func catchPokemon()
}

extension Actions: CatchActions {
    func catchPokemon() {
        dataProvider?.catchPokemon()
    }
}
