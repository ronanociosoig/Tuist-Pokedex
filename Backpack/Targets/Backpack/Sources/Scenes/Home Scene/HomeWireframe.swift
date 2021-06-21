//
//  HomeWireframe.swift
//  Backpack
//
//  Created by Ronan O Ciosig on 15/6/21.
//  Copyright © 2021 Sonomos.com. All rights reserved.
//

import UIKit

class HomeWireframe {
    
    static func makeViewController() -> HomeViewController {
        let storyboard = UIStoryboard.init(name: "HomeViewController", bundle: nil)
        return HomeViewController.instantiateFromStoryboard(storyboard: storyboard)
    }
    
    static func prepare(_ viewController: HomeViewController, actions: HomeActions, dataProvider: HomeDataProvider) {
        let presenter =  HomePresenter(view: viewController, actions: actions, dataProvider: dataProvider)
        viewController.presenter = presenter
    }
    
}
