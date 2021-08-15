//
//  Coordinator.swift
//  Wefox Pokedex
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import Foundation
import SwiftUI
import PokedexCommon
import BackpackUI

class Coordinator: Coordinating {
    let window: UIWindow
    var dataProvider: DataProvider?
    lazy var actions = Actions(coordinator: self)
    var currentViewController: UIViewController?
    
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
    }
    
    func start() {
        actions.dataProvider = dataProvider
        
        showHomeScene()
    }

    func showHomeScene() {
        guard let dataProvider = dataProvider else { return }
        let viewController = HomeWireframe.makeViewController()
        HomeWireframe.prepare(viewController, actions: actions as HomeActions, dataProvider: dataProvider as HomeDataProvider)
        
        window.rootViewController = viewController
    }

    func showBackpackScene() {
        guard let dataProvider = dataProvider else { return }
        
        let navigationController = BackpackWireframe.makeNavigationController()
        guard let viewController = navigationController.topViewController as? BackpackViewController else { return }
        
        BackpackWireframe.prepare(viewController,
                                  actions: actions as BackpackActions,
                                  dataProvider: dataProvider as BackpackDataProvider)
        
        guard let topViewController = window.rootViewController else { return }
        
        topViewController.present(navigationController, animated: true, completion: nil)
        
        currentViewController = navigationController
    }
    
    func showPokemonDetailScene(pokemon: LocalPokemon) {
        let viewController = PokemonDetailWireframe.makeViewController()
        
        PokemonDetailWireframe.prepare(viewController, pokemon: pokemon)
        
        guard let topViewController = currentViewController as? UINavigationController else { return }
        
        topViewController.pushViewController(viewController, animated: true)
    }

    func showAlert(with message: String) {
        let alertController = UIAlertController(title: nil,
                                                message: message,
                                                preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: Constants.Translations.ok,
                                     style: .default,
                                     handler: nil)
        
        alertController.addAction(okButton)
        
        guard let viewController = currentViewController else { return }
        
        viewController.present(alertController,
                               animated: true,
                               completion: nil)
    }
    
    func showLoading() {
        
    }
    
    func dismissLoading() {
        
    }
    
    func showCatchScene() {
        
    }
}
