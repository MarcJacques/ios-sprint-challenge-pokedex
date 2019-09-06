//
//  Pokemon.swift
//  Pokedex
//
//  Created by Marc Jacques on 9/6/19.
//  Copyright © 2019 Marc Jacques. All rights reserved.
//

import Foundation
import SpriteKit

struct PokeDex: Decodable {
    let pokedex: Pokemon
}

struct Pokemon: Decodable {
    let name: String
    let types: [Type]
    let id: Int
    let abilities: [Ability]
    let picture: Sprite
}

struct Type: Decodable {
    let type: Species
}

struct Ability: Decodable {
    let ability : Species
}

struct Sprite: Decodable {
    var frontDefault: URL
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct Species: Decodable {
    let name: String
}
