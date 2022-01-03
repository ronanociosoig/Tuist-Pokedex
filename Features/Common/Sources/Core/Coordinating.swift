//
//  Coordinating.swift
//  Common
//
//  Created by Ronan O Ciosig on 19/5/21.
//  Copyright © 2021 Sonomos. All rights reserved.
//

import Foundation

public protocol Coordinating {
    var dataProvider: DataProvider? { get set }
    
    func start()
    func showLoading()
    func dismissLoading()
    func showHomeScene()
    func showCatchScene()
    func showBackpackScene()
    func showPokemonDetailScene(pokemon: LocalPokemon)
    func showAlert(with errorMessage: String)
}
