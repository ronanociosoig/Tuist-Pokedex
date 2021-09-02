//
//  PokemonDetailPresenter.swift
//  Pokedex
//
//  Created by Ronan on 10/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import Foundation
import Common

protocol PokemonDetailView: AnyObject {
    
}

protocol PokemonDetailPresenting: AnyObject {
    func weight() -> String
    func name() -> String
    func height() -> String
    func imagePath() -> String?
    func baseExperience() -> String
    func date() -> String
    func types() -> String
}

class PokemonDetailPresenter: PokemonDetailPresenting {
    
    // MARK: Properties
    private let pokemon: LocalPokemon
    private weak var view: PokemonDetailView?

    // MARK: Typealias
    typealias View = PokemonDetailView
    
    required init(view: PokemonDetailView, pokemon: LocalPokemon) {
        self.view = view
        self.pokemon = pokemon
    }
    
    func weight() -> String {
        return "\(Constants.Translations.DetailScene.weight): \(pokemon.weight)"
    }
    
    func height() -> String {
        return "\(Constants.Translations.DetailScene.height): \(pokemon.height)"
    }
    
    func name() -> String {
        return pokemon.name
    }
    
    func imagePath() -> String? {
        return pokemon.spriteUrlString
    }
    
    func baseExperience() -> String {
        return "\(Constants.Translations.DetailScene.experience): \(pokemon.baseExperience)"
    }
    
    func date() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/mm/yyyy HH:MM"
        return formatter.string(from: pokemon.date)
    }
    
    func types() -> String {
        var allTypes: String = Constants.Translations.DetailScene.types + ": "
        for type in pokemon.types {
            allTypes.append(type.capitalized)
            allTypes.append(", ")
        }
        return allTypes
    }
}
