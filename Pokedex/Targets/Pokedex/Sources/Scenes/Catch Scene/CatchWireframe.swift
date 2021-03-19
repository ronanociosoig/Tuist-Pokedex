//
//  CatchWireframe.swift
//  Pokedex
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import UIKit

class CatchWireframe {
    
    static func makeViewController() -> CatchViewController {
        let storyboard = UIStoryboard.init(name: "CatchViewController", bundle: nil)
        return CatchViewController.instantiateFromStoryboard(storyboard: storyboard)
    }
    
    static func prepare(_ viewController: CatchViewController,
                        actions: CatchActions,
                        dataProvider: CatchDataProvider) {
    	let presenter =  CatchPresenter(view: viewController,
                                        actions: actions,
                                        dataProvider: dataProvider)
        viewController.presenter = presenter
    }
    
}
