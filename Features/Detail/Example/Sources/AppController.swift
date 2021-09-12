//
//  AppController.swift
//  DetailExample
//
//  Created by Ronan on 12/09/2021.
//  Copyright © 2021 Sonomos. All rights reserved.
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
        dataProvider.notifier = coordinator as? Notifier
        dataProvider.appData.pokemons = MockDataFactory.makePokemons()

        coordinator = Coordinator()
        coordinator?.dataProvider = dataProvider
        coordinator?.start()

        
    }
}
