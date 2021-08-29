//
//  AppController.swift
//  Wefox Pokedex
//
//  Created by Ronan on 01/07/21.
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

        dataProvider.start()
        
        coordinator = Coordinator()
        coordinator?.dataProvider = dataProvider
        coordinator?.start()
        
        dataProvider.notifier = coordinator as? Notifier
    }
}
