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

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return apiController.pokemon.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokedexCell", for: indexPath)
        
        let pokemon = apiController.pokemon[indexPath.row]
        
        cell.textLabel?.text = pokemon.name.capitalized
        guard let imageData = try? Data(contentsOf: pokemon.picture.frontDefault) else {
            fatalError() }
        cell.imageView?.image = UIImage(data: imageData)
        return cell
        }

    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

  
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailViewSegue" {
            guard let pokemonDetailVC = segue.destination as? PokemonDetailViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let pokemon = apiController.pokemon[indexPath.row]
            pokemonDetailVC.pokemon = pokemon
        }
        }
    }
