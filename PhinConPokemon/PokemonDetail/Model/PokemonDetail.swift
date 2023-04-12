//
//  PokemonDetail.swift
//  PhinConPokemon
//
//  Created by Administrator on 11/04/23.
//

import Foundation

struct PokemonDetail: Codable {
    let id: Int?
    let name: String?
    let sprites: PokemonSprites?
    let weight: Int?
    let height: Int?
    let types: [Types]?
    let moves: [Moves]?
}

struct Types: Codable {
    let slot: Int?
    let type: TypePokemon?
}

struct TypePokemon: Codable {
    let name: String?
    let url: String?
}

struct Moves: Codable {
    let move: MovePokemon?
}

struct MovePokemon: Codable {
    let name: String?
    let url: String?
}
