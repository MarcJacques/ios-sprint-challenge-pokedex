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
    
    @IBOutlet weak var allLabels: UIStackView!
    
    // Mark Properties:
    
    var apiController: APIController?
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
        apiController?.add(pokemon: pokemon)
        saveButton.isEnabled = false
        self.navigationController?.popViewController(animated: true)
    }
    
    //  Mark: - Helper Functions
    
    private func labelHider(_ hide: Bool) {
//        pokemonNameLabel.isHidden = hide
//        imageView.isHidden = hide
//        idLabel.isHidden = hide
//        typeLabel.isHidden = hide
//        abilitiesLabel.isHidden = hide
        allLabels.isHidden = hide
    }

    private func updateViews() {
        guard let pokemon = pokemon, isViewLoaded else { return }
        title = pokemon.name.capitalized + " " + "ID: \(pokemon.id)" 
        idLabel.text = "\(pokemon.id)"
        typeLabel.text = "\(pokemon.types.map{$0.type.name}.joined(separator: ", ") )"
        abilitiesLabel.text = "\(pokemon.abilities.map{$0.ability.name}.joined(separator: ", "))"
        guard let imageData = try? Data(contentsOf: pokemon.sprites.frontDefault) else { return }
        imageView.image = UIImage(data: imageData)
        
    }
    private func performSearch(for searchTerm: String) {
        apiController?.gottaCatchThemAll(by: searchTerm) { (result) in
            guard let result = try? result.get() else { return }
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
        guard let searchTerm = searchBar.text else { return }
        performSearch(for: searchTerm)
    }
}

extension UISearchBar {
    var optionalText: String? {
        let trimmedText = self.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        return (trimmedText ?? "").isEmpty ? nil : trimmedText
    }
}

