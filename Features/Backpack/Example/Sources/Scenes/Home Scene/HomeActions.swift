//
//  HomeViewActions.swift
//  Backpack
//
//  Created by Ronan O Ciosig on 15/6/21.
//  Copyright © 2021 Sonomos.com. All rights reserved.
//

import Foundation
import Common

protocol HomeActions {
    func backpackButtonAction()
}

extension Actions: HomeActions {
    func backpackButtonAction() {
        coordinator.showBackpackScene()
    }
}
