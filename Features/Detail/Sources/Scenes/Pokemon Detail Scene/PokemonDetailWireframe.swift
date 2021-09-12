//
//  PokemonDetailWireframe.swift
//  Pokedex
//
//  Created by Ronan on 10/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import UIKit
import Common

public class PokemonDetailWireframe {
    
    public static func makeViewController() -> PokemonDetailViewController {
        let storyboard = UIStoryboard.init(name: "PokemonDetailViewController", bundle: Bundle(for: PokemonDetailViewController.self))
        return PokemonDetailViewController.instantiateFromStoryboard(storyboard: storyboard)
    }
    
    public static func prepare(_ viewController: PokemonDetailViewController, pokemon: LocalPokemon) {
    	let presenter =  PokemonDetailPresenter(view: viewController, pokemon: pokemon)
        viewController.presenter = presenter
    }
    
}
