//
//  AppController.swift
//  Pokedex
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import Foundation
import Common

protocol AppControlling {
    func start()
}

class AppController: AppControlling {
    var coordinator: Coordinating?
    
    func start() {
        let dataProvider = DataProvider()
        
        if Configuration.uiTesting == true {
            let storage = FileStorage()
            storage.remove(AppData.pokemonFile, from: dataProvider.appData.directory())
        }
        
        dataProvider.start()
        
        coordinator = Coordinator()
        coordinator?.dataProvider = dataProvider
        coordinator?.start()
        
        dataProvider.notifier = coordinator as? Notifier
    }
}
