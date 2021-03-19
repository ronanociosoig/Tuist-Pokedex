//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Ronan on 10/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import UIKit
import Haneke

class PokemonDetailViewController: UIViewController {
    var presenter: PokemonDetailPresenting?
    
    private var pokemonView: PokemonView?
    
    override func viewDidLoad() {
        addPokemonView()
    }
    
    private func addPokemonView() {
        guard let pokemonView = PokemonView.loadFromNib() else { return }
        
        view.addSubview(pokemonView)
        
        pokemonView.center = view.center
        var point = pokemonView.center
        let height = pokemonView.frame.size.height
        point.y = height/2
        pokemonView.center = point
        
        self.pokemonView = pokemonView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configurePokemonView()
    }
    
    private func configurePokemonView() {
        guard let presenter = presenter else { return }
        guard let pokemonView = pokemonView else { return }
        
        pokemonView.weight.text = presenter.weight()
        pokemonView.height.text = presenter.height()
        pokemonView.name.text = ""
        
        pokemonView.experience.isHidden = false
        pokemonView.experience.text = presenter.baseExperience()
        
        pokemonView.date.isHidden = false
        pokemonView.date.text = presenter.date()
        
        pokemonView.types.isHidden = false
        pokemonView.types.text = presenter.types()
        
        title = presenter.name().capitalized
        
        guard let imagePath = presenter.imagePath() else { return }
        guard let imageURL = URL(string: imagePath) else { return }
        pokemonView.imageView.hnk_setImage(from: imageURL)
    }
}

extension PokemonDetailViewController: PokemonDetailView {

}
