//
//  Pokemon.swift
//  MakerDex
//
//  Created by Sung Kim on 4/22/17.
//  Copyright © 2017 sungkim.tech. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int?
    private var _description: String!
    private var _type: String!
    private var _defence: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLvl: String!
    private var _pokemonUrl: String!
    
    var description: String{
        if _description == nil{
            _nextEvolutionLvl =  ""
        }
        return _description
    }
    
    var type: String{
        if _type == nil{
            _type = ""
        }
        return _type
    }
    
    var defence: String{
        if _defence == nil{
            _defence = ""
        }
        return _defence
    }
    
    var height: String{
        if _height == nil{
            _height = ""
        }
        return _height
    }
    
    var weight: String{
        if _weight == nil{
            _weight = ""
        }
        return _weight
    }
    
    var attack: String{
        if _attack == nil{
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionTxt: String{
        if _nextEvolutionTxt == nil{
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    var nextEvolutionId: String{
        if _nextEvolutionId == nil{
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionLvl: String{
        if _nextEvolutionLvl == nil{
            _nextEvolutionLvl = ""
        }
        return _nextEvolutionLvl
    }
    
    var name: String{
        return _name
    }
    
    var pokedexId: Int{
        return _pokedexId!
    }
    
    let URL_BASE = "http://pokeapi.co"
    let URL_POKEMON = "/api/v1/pokemon/"
    typealias DownloadComplete = () -> ()

    
    init(name: String, pokedexId: Int){
        self._name = name
        self._pokedexId = pokedexId
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId!)/"
    }
    
    func downloadPokemonDetails (completed: @escaping DownloadComplete){
        
        let pokemonUrl = URL(string: self._pokemonUrl)!
        
        Alamofire.request(pokemonUrl).responseJSON { response in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject>{
                
                //                print(response)
                
                if let weight = dict["weight"] as? String{
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String{
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int{
                    self._attack = "\(attack)"
                }
                
                if let defence = dict["defense"] as? Int{
                    self._defence = "\(defence)"
                }
                
                //                print(self._weight)
                //                print(self._height)
                //                print(self._attack)
                //                print(self._defence)
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    if let name = types[0]["name"]{
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1  {
                        for x in 1 ..< types.count {
                            if let name = types[x]["name"]{
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                } else {
                    self._type = ""
                }
                //                print (self._type)
                
                if let descArr = dict ["descriptions"] as? [Dictionary <String, String>], descArr.count > 0{
                    
                    if let url = descArr[0]["resource_uri"]{
                        
                        let pokemonDescriptionUrl = URL(string: "\(self.URL_BASE)\(url)")!
                        Alamofire.request(pokemonDescriptionUrl).responseJSON { response in
                            
                            if let descDict = response.result.value as? Dictionary<String, AnyObject>{
                                
                                if let description = descDict["description"] as? String {
                                    self._description = description
                                    //                                    print (self._description)
                                }
                            }
                            completed()
                        }
                    }
                    
                } else {
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary <String, AnyObject>], evolutions.count > 0 {
                    
                    if let to = evolutions[0]["to"] as? String{
                        
                        //Mega is not found
                        if to.range(of: "mega") == nil{
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                
                                let num = newStr.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvolutionId = num
                                self._nextEvolutionTxt = to
                                
                                if let lvl = evolutions[0]["level"] as? Int{
                                    self._nextEvolutionLvl = "\(lvl)"
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
