//
//  CatchActions.swift
//  CatchUI
//
//  Created by Ronan on 01/07/21.
//  Copyright © 2021 Sonomos. All rights reserved.
//

import Common

public protocol CatchActions {
    func catchPokemon()
}

extension Actions: CatchActions {
    public func catchPokemon() {
        dataProvider?.catchPokemon()
    }
}
