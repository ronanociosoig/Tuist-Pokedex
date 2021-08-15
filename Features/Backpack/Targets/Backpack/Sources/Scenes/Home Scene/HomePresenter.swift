//
//  HomePresenter.swift
//  Backpack
//
//  Created by Ronan O Ciosig on 15/6/21.
//  Copyright © 2021 Sonomos.com. All rights reserved.
//

import Foundation

protocol HomeView: AnyObject {
    
}

protocol HomePresenting: AnyObject {
    func backpackButtonAction()
}

class HomePresenter: HomePresenting {
    
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

    func backpackButtonAction() {
        actions.backpackButtonAction()
    }
}
