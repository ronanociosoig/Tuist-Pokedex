//
//  HomeViewActions.swift
//  Catch
//
//  Created by Ronan O Ciosig on 01/07/21.
//  Copyright © 2021 Sonomos.com. All rights reserved.
//

import Foundation
import PokedexCommon

protocol HomeActions {
    func catchButtonAction()
}

extension Actions: HomeActions {
    func catchButtonAction() {
        coordinator.showCatchScene()
    }
}
