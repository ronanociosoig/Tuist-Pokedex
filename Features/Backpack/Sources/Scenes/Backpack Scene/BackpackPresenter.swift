//
//  BackpackPresenter.swift
//  Pokedex
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

// swiftlint:disable weak_delegate

import Common

protocol BackpackView: AnyObject {
    func setDataSource(dataSource: BackpackDataSource)
}

protocol BackpackPresenting: AnyObject {
    var dataSource: BackpackDataSource { get }
    var delegate: BackpackDelegate { get }
    
    func viewDidLoad()
    func pokemons() -> [LocalPokemon]
    func pokemonImagePath(at index: Int) -> String?
    func pokemonName(at index: Int) -> String
    func selectItem(at index: Int)
}

class BackpackPresenter: BackpackPresenting {
    
    // MARK: Properties
    
    private weak var view: BackpackView?
    private var actions: BackpackActions
    private var dataProvider: BackpackDataProvider
    var dataSource: BackpackDataSource
    var delegate: BackpackDelegate
    
    // MARK: Typealias
    
    typealias Actions = BackpackActions
    typealias DataProvider = BackpackDataProvider
    typealias View = BackpackView
    typealias DataSource = BackpackDataSource
    typealias Delegate = BackpackDelegate
    
    required init(actions: BackpackActions, dataProvider: BackpackDataProvider, view: BackpackView) {
        self.view = view
        self.actions = actions
        self.dataProvider = dataProvider
        delegate = BackpackDelegate()
        dataSource = BackpackDataSource()
   		delegate.presenter = self
        dataSource.presenter = self
    }
    
    func viewDidLoad() {
        view?.setDataSource(dataSource: dataSource)
    }
    
    func pokemons() -> [LocalPokemon] {
        return dataProvider.pokemons()
    }
    
    func pokemonImagePath(at index: Int) -> String? {
        return pokemons()[index].spriteUrlString
    }
    
    func pokemonName(at index: Int) -> String {
        return pokemons()[index].name.capitalized
    }
    
    func selectItem(at index: Int) {
        actions.selectItem(at: index)
    }
}
