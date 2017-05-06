//
//  PokemonCollectionViewCell.swift
//  MakerDex
//
//  Created by Sung Kim on 4/8/17.
//  Copyright © 2017 sungkim.tech. All rights reserved.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    
    var pokemon: Pokemon!
    
    func configureCell(pokemon: Pokemon){
        self.pokemon = pokemon
        
        pokemonName.text = self.pokemon.name.capitalized
        pokemonImageView.image = UIImage(named: "\(String(describing: self.pokemon.pokedexId))")
    }
}
