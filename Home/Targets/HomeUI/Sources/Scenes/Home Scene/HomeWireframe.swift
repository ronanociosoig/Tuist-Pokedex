//
//  HomeWireframe.swift
//  Pokedex
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import UIKit

public class HomeWireframe {
    
    public static func makeViewController() -> HomeViewController {
        let storyboard = UIStoryboard.init(name: "HomeViewController", bundle: Bundle(for: HomeViewController.self))
        return HomeViewController.instantiateFromStoryboard(storyboard: storyboard)
    }
    
    public static func prepare(_ viewController: HomeViewController, actions: HomeActions, dataProvider: HomeDataProvider) {
    	let presenter =  HomePresenter(view: viewController, actions: actions, dataProvider: dataProvider)
        viewController.presenter = presenter
    }
}
