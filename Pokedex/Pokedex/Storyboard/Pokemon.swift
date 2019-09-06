//
//  Pokemon.swift
//  Pokedex
//
//  Created by Marc Jacques on 9/6/19.
//  Copyright © 2019 Marc Jacques. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    var name: String
    var types: [Type]
    var id: Int
    var abilities: [Ability]
    var picture: Sprite
}

struct Type: Decodable {
    var type: Species
}

struct Ability: Decodable {
    var ability : Species
}

struct Sprite: Decodable {
    var frontDefault: URL
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct Species: Decodable {
    var name: String
}
