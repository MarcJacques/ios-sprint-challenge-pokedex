//
//  Pokemon.swift
//  Pokedex
//
//  Created by Marc Jacques on 9/6/19.
//  Copyright © 2019 Marc Jacques. All rights reserved.
//

import Foundation

struct Pokemon: Equatable, Codable {
    var name: String
    var id: Int
    var abilities: [Abilities]
    var types: [Types]
    var sprites : Sprite
}

struct Types: Equatable, Codable {
    var type: Type
}

struct Abilities: Equatable, Codable {
    var ability : Ability
}

struct Ability: Equatable, Codable {
    var name: String
}

struct Sprite: Equatable, Codable {
    var frontDefault: URL
    
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct Type: Equatable, Codable {
    var name: String
}
