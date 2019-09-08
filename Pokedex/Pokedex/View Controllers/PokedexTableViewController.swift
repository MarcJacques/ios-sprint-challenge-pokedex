//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Marc Jacques on 9/6/19.
//  Copyright © 2019 Marc Jacques. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    let apiController = APIController()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return apiController.pokeBall.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokedexCell", for: indexPath)
        
        let pokemon = apiController.pokeBall[indexPath.row]
        
        cell.textLabel?.text = pokemon.name.capitalized
        guard let imageData = try? Data(contentsOf: pokemon.sprites.frontDefault) else {
            fatalError() }
        cell.imageView?.image = UIImage(data: imageData)
        
        return cell
        }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            self.apiController.remove(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            handler(true)
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    

  

   

  
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailViewSegue" {
            guard let pokemonDetailVC = segue.destination as? PokemonDetailViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let pokemon = apiController.pokeBall[indexPath.row]
            pokemonDetailVC.pokemon = pokemon
        } else if segue.identifier == "PokemonSearchSegue" {
            if let pokemonSearchVC = segue.destination as? PokemonSearchViewController {
                pokemonSearchVC.apiController = apiController
            }
        }
        }
    }
