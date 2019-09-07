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
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    func getPokemon(by searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {

        let pokemonURL = baseURL.appendingPathComponent("\(searchTerm.lowercased())")
        let request = URLRequest(url: pokemonURL)
       

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    print (response.statusCode)
                }
            }
            
            if let error = error {
                NSLog(error.localizedDescription)
                completion(.failure(.otherError(error)))
                return
            }

            guard let data = data else {
                NSLog("No data returned from data task.")
                completion(.failure(.noData)) //if we don't get data get out
                return
            }
            do {
                //print (String(describing: data))
                let pokemonFound = try JSONDecoder().decode(Pokemon.self, from: data) // userResults.self is collecting all of the data from the API
                //print(pokemonFound)
                completion(.success(pokemonFound))
                //make the empty array = to the new array that you just collected from the api
            } catch {
                NSLog("Error decoding pokemon.")
                completion(.failure(.notDecoding))
            }
            }.resume()
    }
}
