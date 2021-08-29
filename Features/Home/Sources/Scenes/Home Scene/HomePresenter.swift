//
//  HomePresenter.swift
//  Pokedex
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

public protocol HomeView: AnyObject {
    
}

public protocol HomePresenting: AnyObject {
    func ballButtonAction()
    func backpackButtonAction()
}

public class HomePresenter: HomePresenting {
    
    // MARK: Properties
    
    private weak var view: HomeView?
    private var actions: HomeActions
    private var dataProvider: HomeDataProvider
    
    // MARK: Typealias
    
    typealias Actions = HomeActions
    typealias DataProvider = HomeDataProvider
    typealias View = HomeView
    
    required init(view: HomeView, actions: HomeActions, dataProvider: HomeDataProvider) {
        self.view = view
        self.actions = actions
        self.dataProvider = dataProvider
    }
    
    public func ballButtonAction() {
        actions.ballButtonAction()
    }
    
    public func backpackButtonAction() {
        actions.backpackButtonAction()
    }
}
