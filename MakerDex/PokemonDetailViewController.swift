//
//  PokemonDetailViewController.swift
//  MakerDex
//
//  Created by Sung Kim on 5/13/17.
//  Copyright © 2017 sungkim.tech. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet weak var primaryImageView: UIImageView!
    @IBOutlet weak var pokemonInfoTextView: UITextView!
    
    @IBOutlet weak var pokemonTypeLbl: UILabel!
    @IBOutlet weak var pokemonHeightLbl: UILabel!
    @IBOutlet weak var pokemonDefenceLbl: UILabel!

    @IBOutlet weak var pokemonIDLbl: UILabel!
    @IBOutlet weak var pokemonWeightLbl: UILabel!
    @IBOutlet weak var pokemonAttackLbl: UILabel!

    @IBOutlet weak var nextEvolutionLbl: UILabel!
    @IBOutlet weak var firstEvolutionImageView: UIImageView!
    @IBOutlet weak var secondEvolutionImageView: UIImageView!
    
    var pokemon: Pokemon!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = pokemon.name.capitalized
        self.pokemonIDLbl.text = "\(pokemon.pokedexId)"
        self.primaryImageView.image = UIImage(named: "\(pokemon.pokedexId)")
        self.firstEvolutionImageView.image = UIImage(named: "\(pokemon.pokedexId)")
        
        
        pokemon.downloadPokemonDetails {
            self.updateUI()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Functions
    
    func updateUI() {
        self.pokemonInfoTextView.text = pokemon.description
        self.pokemonTypeLbl.text = pokemon.type
        self.pokemonAttackLbl.text = pokemon.attack
        self.pokemonDefenceLbl.text = pokemon.defence
        self.pokemonHeightLbl.text = pokemon.height
        self.pokemonWeightLbl.text = pokemon.weight
        
        if pokemon.nextEvolutionId == ""{
            self.nextEvolutionLbl.text = "No Evolutions"
            self.secondEvolutionImageView.isHidden = true
        } else {
            self.secondEvolutionImageView.isHidden = false
            self.secondEvolutionImageView.image = UIImage(named: pokemon.nextEvolutionId)
            let str = "Next Evolution: \(pokemon.nextEvolutionTxt)"
            
            self.nextEvolutionLbl.text = str
            
//            if pokemon.nextEvolutionLvl != ""{
//                str += " - LVL \(pokemon.nextEvolutionTxt)"
//            }
        }
    }
    
}
