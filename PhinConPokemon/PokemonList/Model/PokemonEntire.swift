//
//  PokemonEntire.swift
//  PhinConPokemon
//
//  Created by Administrator on 11/04/23.
//

import Foundation

struct PokemonEntire: Codable {
    var results: [PokemonEntireData]?
}

struct PokemonEntireData: Codable {
    var name: String?
    var url: String?
}
