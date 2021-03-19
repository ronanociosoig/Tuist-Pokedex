//
//  Actions.swift
//  Pokedex
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import Foundation

class Actions {
    let coordinator: Coordinating
    var dataProvider: DataProviding?
    
    init(coordinator: Coordinating) {
        self.coordinator = coordinator
    }
}
