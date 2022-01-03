//
//  DataProviding.swift
//  Common
//
//  Created by Ronan O Ciosig on 5/6/21.
//  Copyright © 2021 Sonomos. All rights reserved.
//

import Foundation

public protocol DataProviding {
    func catchPokemon()
    func newSpecies() -> Bool
    func pokemon(at index: Int) -> LocalPokemon
}
