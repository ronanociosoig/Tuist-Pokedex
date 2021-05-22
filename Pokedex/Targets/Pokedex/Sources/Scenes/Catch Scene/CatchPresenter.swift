//
//  CatchPresenter.swift
//  Pokedex
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

protocol CatchView: AnyObject {
    func update()
    func showLeaveOrCatchAlert()
    func showLeaveItAlert()
    func showNotFoundAlert()
    func showError(message: String)
}

protocol CatchPresenting: AnyObject {
    func pokemon() -> ScreenPokemon?
    func catchPokemonAction()
}

class CatchPresenter: CatchPresenting, Updatable {

    // MARK: Properties
    
    private weak var view: CatchView?
    private var actions: CatchActions
    private var dataProvider: CatchDataProvider
    
    // MARK: Typealias
    
    typealias Actions = CatchActions
    typealias DataProvider = CatchDataProvider
    typealias View = CatchView
    
    required init(view: CatchView, actions: CatchActions, dataProvider: CatchDataProvider) {
        self.view = view
        self.actions = actions
        self.dataProvider = dataProvider
    }
    
    func update() {
        guard let view = view else { return }
        view.update()
        
        if pokemon() == nil {
            view.showNotFoundAlert()
            return
        }
        
        dataProvider.newSpecies() ? view.showLeaveOrCatchAlert() : view.showLeaveItAlert()
    }
    
    func showError(message: String) {
        view?.showError(message: message)
    }
    
    func pokemon() -> ScreenPokemon? {
        return dataProvider.pokemon()
    }
    
    func catchPokemonAction() {
        actions.catchPokemon()
    }
}
