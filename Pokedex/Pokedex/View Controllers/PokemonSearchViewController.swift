//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Marc Jacques on 9/6/19.
//  Copyright © 2019 Marc Jacques. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    // Mark Properties:
    
    var apiController: APIController!
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        hideViews(true)
        saveButton.isHidden = true
        
        if let pokemon = pokemon {
            title = pokemon.name
            searchBar.isHidden = true
            updateViews()
        }
    }
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let pokemon = pokemon else { return }
        apiController.add(pokemon: pokemon)
        saveButton.isEnabled = false
    }
    
    //  Mark: - Helper Functions
    
    private func hideViews(_ verdict Bool) {
        pokemonNameLabel.isHidden = verdict
        imageView.isHidden = verdict
        idLabel.isHidden = verdict
        typeLabel.isHidden = verdict
        abilitiesLabel.isHidden = verdict
    }
    
    private func updateViews() {
        guard let pokemon = pokemon else { return }
        title = pokemon.name.capitalized
        idLabel.text = "\(pokemon.id)"
        typeLabel.text = "\(pokemon.types)"
        abilitiesLabel.text = "\(pokemon.abilities)"
    }
    
    private func performSearch(for searchTerm: String) {
        apiController.getPokemon(by: searchTerm) { (result) in
            guard let result = try? result.get() else { return }
            DispatchQueue.main.async {
                self.pokemon = result
                self.updateViews()
                self.saveButton.isEnabled = true
                self.saveButton.isHidden = false
            }
            
        }
    }
}

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        performSearch(for: searchTerm)
    }
}

