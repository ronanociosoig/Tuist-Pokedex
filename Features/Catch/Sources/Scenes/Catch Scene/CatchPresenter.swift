//
//  CatchPresenter.swift
//  CatchUI
//
//  Created by Ronan on 01/07/21.
//  Copyright © 2021 Sonomos. All rights reserved.
//

import Common

protocol CatchView: AnyObject {
    func update()
    func showLeaveOrCatchAlert()
    func showLeaveItAlert()
    func showNotFoundAlert()
    func showError(message: String)
}

public protocol CatchPresenting: AnyObject {
    func pokemon() -> ScreenPokemon?
    func catchPokemonAction()
}

public class CatchPresenter: CatchPresenting, Updatable {

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
    
    public func update() {
        guard let view = view else { return }
        view.update()
        
        if pokemon() == nil {
            view.showNotFoundAlert()
            return
        }
        
        dataProvider.newSpecies() ? view.showLeaveOrCatchAlert() : view.showLeaveItAlert()
    }
    
    public func showError(message: String) {
        view?.showError(message: message)
    }
    
    public func pokemon() -> ScreenPokemon? {
        return dataProvider.pokemon()
    }
    
    public func catchPokemonAction() {
        actions.catchPokemon()
    }
}
