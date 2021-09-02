//
//  BackpackDelegate.swift
//  Pokedex
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import UIKit

class BackpackDelegate: NSObject, UICollectionViewDelegate {
    
    weak var presenter: BackpackPresenting?
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let presenter = presenter else { return }
        presenter.selectItem(at: indexPath.item)
    }
}
