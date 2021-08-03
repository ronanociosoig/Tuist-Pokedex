//
//  HomePresenter.swift
//  Catch
//
//  Created by Ronan O Ciosig on 01/07/21.
//  Copyright © 2021 Sonomos.com. All rights reserved.
//

import Foundation

protocol HomeView: AnyObject {
    
}

protocol HomePresenting: AnyObject {
    func catchButtonAction()
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

    func catchButtonAction() {
        actions.catchButtonAction()
    }
}
