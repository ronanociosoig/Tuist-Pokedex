//
//  BackpackDataSource.swift
//  Pokedex
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import UIKit
import Haneke

class BackpackDataSource: NSObject, UICollectionViewDataSource {
    
    weak var presenter: BackpackPresenting?
    
    func register(collectionView: UICollectionView) {
        collectionView.register(cellType: PokemonCollectionViewCell.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let presenter = presenter else { return 0 }
        
        return presenter.pokemons().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cellType: PokemonCollectionViewCell.self, for: indexPath)
        
        guard let presenter = presenter else { return cell }
        
        cell.name.text = presenter.pokemonName(at: indexPath.item)
        guard let imagePath = presenter.pokemonImagePath(at: indexPath.item) else {
            return cell
        }
        
        guard let imageURL = URL(string: imagePath) else { return cell }
        cell.imageView.hnk_setImage(from: imageURL, placeholder: UIImage(named: Constants.Image.pokemonPlaceholder))
        
        return cell
    }
}
