//
//  HomeViewController.swift
//  Catch
//
//  Created by Ronan O Ciosig on 01/07/21.
//  Copyright © 2021 Sonomos.com. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var presenter: HomePresenting?
    
    @IBAction func catchButtonAction() {
        guard let presenter = presenter else { return }
        presenter.catchButtonAction()
    }
}

extension HomeViewController: HomeView {
    
}
