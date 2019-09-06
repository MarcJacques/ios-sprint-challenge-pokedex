//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Marc Jacques on 9/6/19.
//  Copyright © 2019 Marc Jacques. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            updateViews()
    }
    
    func updateViews() {
        guard isViewLoaded,
        let pokemon = pokemon else { return }
        title = pokemon.name.capitalized
        idLabel.text = "\(pokemon.id)"
        typeLabel.text = "\(pokemon.types)"
        guard let imageData = try? Data(contentsOf: pokemon.picture.frontDefault) else { fatalError() }
        imageView.image = UIImage(data: imageData)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
