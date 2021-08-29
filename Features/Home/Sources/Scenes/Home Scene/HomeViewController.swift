//
//  HomeViewController.swift
//  Pokedex
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import UIKit

public class HomeViewController: UIViewController {
    var presenter: HomePresenting?

    @IBAction func ballButtonAction() {
        guard let presenter = presenter else { return }
        presenter.ballButtonAction()
    }
    
    @IBAction func backpackButtonAction() {
        guard let presenter = presenter else { return }
        presenter.backpackButtonAction()
    }
}

extension HomeViewController: HomeView {
    
}
