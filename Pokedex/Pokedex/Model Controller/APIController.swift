//
//  APIController.swift
//  Pokedex
//
//  Created by Marc Jacques on 9/6/19.
//  Copyright © 2019 Marc Jacques. All rights reserved.
//

import Foundation

class APIController {
    
    var myPokemon: [Pokemon] = []
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    typealias CompletionHandler = (Error?) -> Void // if we run into an error hop out of the closure
    
    func add(pokemon: Pokemon) {
        if !myPokemon.contains(pokemon) {
            myPokemon.append(pokemon)
        }
    }
    
    func getPokemon(by searchTerm: String, completion: @escaping CompletionHandler = { _ in }) {
        
        let pokemonURL = baseURL.appendingPathComponent(searchTerm.lowercased())
        let request = URLRequest(url: pokemonURL)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error { // were using if let because we don't really care whether or not theres an error
                NSLog("Error getting pokemon: \(error)") //NSLOG documents more info such as time and other details
            }
            guard let data = data else { // we absolutely need data so we use guard
                NSLog("No data returned from data task.")
                completion(nil) //if we don't get data get out
                return
            }
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                self.pokemon = [pokemon.self]
            } catch {
                NSLog("Error decoding users: \(error)")
                completion(error)
            }
            completion(nil)
            }.resume()
        
    }
}
