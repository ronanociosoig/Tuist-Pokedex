//
//  HomeActions.swift
//  Pokedex
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

protocol HomeActions {
    func ballButtonAction()
    func backpackButtonAction()
}

extension Actions: HomeActions {
    func ballButtonAction() {
        coordinator.showCatchScene()
    }
    
    func backpackButtonAction() {
        coordinator.showBackpackScene()
    }
}
