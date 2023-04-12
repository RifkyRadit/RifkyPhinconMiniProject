//
//  Pokemon.swift
//  PhinConPokemon
//
//  Created by Administrator on 11/04/23.
//

import Foundation

struct Pokemon: Codable {
    let id: Int?
    let name: String?
    let sprites: PokemonSprites?
    let weight: Int?
    let height: Int?
}

struct PokemonSprites: Codable {
    let frontDefault: String?
    let backDefault: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case backDefault = "back_default"
    }
}
