//
//  BackpackViewController.swift
//  Pokedex
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import UIKit
import Common

public class BackpackViewController: UIViewController {
    var presenter: BackpackPresenting?
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        guard let presenter = presenter else { return }
        presenter.viewDidLoad()
        
        title = Constants.Translations.BackpackScene.title
    }
    
    private func setupCollectionView() {
        guard let presenter = presenter else { return }
        collectionView.delegate = presenter.delegate
        collectionView.dataSource = presenter.dataSource
        collectionView.reloadData()
    }
}

extension BackpackViewController: BackpackView {
    func setDataSource(dataSource: BackpackDataSource) {
        dataSource.register(collectionView: collectionView)
    }
}
