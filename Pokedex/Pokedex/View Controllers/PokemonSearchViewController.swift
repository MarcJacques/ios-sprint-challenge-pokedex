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
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        labelHider(true)
        saveButton.isHidden = true
        
        if let pokemon = pokemon {
            title = pokemon.name
            searchBar.isHidden = true
            updateViews()
        }
    }
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let pokemon = pokemon else { return }
        apiController.pokemon.append(pokemon)
        saveButton.isEnabled = false
        
    }
    
    //  Mark: - Helper Functions
    
    private func labelHider(_ hide: Bool) {
        pokemonNameLabel.isHidden = hide
        imageView.isHidden = hide
        idLabel.isHidden = hide
        typeLabel.isHidden = hide
        abilitiesLabel.isHidden = hide
    }
    
    private func updateViews() {
        guard let pokemon = pokemon, isViewLoaded else { return }
        title = pokemon.name.capitalized
        idLabel.text = "\(pokemon.id)"
        typeLabel.text = "\(pokemon.types)"
        abilitiesLabel.text = "\(pokemon.abilities)"
        guard let imageData = try? Data(contentsOf: pokemon.picture.frontDefault) else { fatalError() }
        imageView.image = UIImage(data: imageData)
        
    }
    private func performSearch(for searchTerm: String) {
        apiController.getPokemon(by: searchTerm) { (result),_  in
            guard let result = try? result. else { return }
            DispatchQueue.main.async {
                self.pokemon = result
                self.labelHider(false)
                self.updateViews()
                self.saveButton.isEnabled = true
                self.saveButton.isHidden = false
            }
        }
    }
}
extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        searchBar.resignFirstResponder()
        apiController.getPokemon(by: searchBar.text, completion: { fatalError() (result) in
            DispatchQueue.main.async {
                do {
                    let pokemon = try result.get()
                    self?.pokemon = pokemon
                } catch {
                    let alertVC = UIAlertController(error: error)
                    self?.present(alertVC, animated: true)
                }
            }
        })
    }
}
