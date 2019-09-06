//
//  APIController.swift
//  Pokedex
//
//  Created by Marc Jacques on 9/6/19.
//  Copyright © 2019 Marc Jacques. All rights reserved.
//

import Foundation

class APIController {
        
    var pokemon: [Pokemon] = []
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    typealias CompletionHandler = (Error?) -> Void
    
    func getPokemon(by searchTerm: String, completion: @escaping CompletionHandler = { _ in }) {
        
        let pokemonURL = baseURL.appendingPathComponent("\(searchTerm.lowercased())")
        let request = URLRequest(url: pokemonURL)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error getting users: \(error)")
            }
            
            guard let data = data else {
                NSLog("No data returned from data task.")
                completion(nil) //if we don't get data get out
                return
            }
            do {
                let pokemonFound = try JSONDecoder().decode(Pokemon.self, from: data) // userResults.self is collecting all of the data from the API
                print(pokemonFound)
                //make the empty array = to the new array that you just collected from the api
            } catch {
                NSLog("Error decoding users: \(error)")
                completion(error)
            }
            completion(nil)
            }.resume()
        
    }
}
