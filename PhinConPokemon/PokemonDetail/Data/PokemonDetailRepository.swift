//
//  PokemonDetailRepository.swift
//  PhinConPokemon
//
//  Created by Administrator on 11/04/23.
//

import UIKit

enum PokemonDetailResult {
    case success(_ dataModel: PokemonDetail?)
    case failed(_ errorMessage: String?)
}

protocol PokemonDetailRepositoryData {
    func getDetailPokemon(url: String, completion: @escaping (PokemonDetailResult) -> Void)
    func saveData(pokemonData: CatchPokemon, completion: @escaping (PokemonDetailResult) -> Void)
}

struct PokemonDetailRepository: PokemonDetailRepositoryData {
    
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func getDetailPokemon(url: String, completion: @escaping (PokemonDetailResult) -> Void) {
        guard let url = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                completion(.failed(error?.localizedDescription))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let object = try jsonDecoder.decode(PokemonDetail.self, from: data)
                completion(.success(object))
                
            } catch let error {
                completion(.failed(error.localizedDescription))
            }
            
            
        }.resume()
    }
    
    func saveData(pokemonData: CatchPokemon, completion: @escaping (PokemonDetailResult) -> Void) {
        guard let context = context else {
            return
        }
        
        let newItem = MyPokemon(context: context)
        newItem.id = pokemonData.id ?? 0
        newItem.pokemonNickname = pokemonData.nickname
        newItem.pokemonName = pokemonData.name
        newItem.pokemonUrlImage = pokemonData.imageUrl
        newItem.pokemonUrlDetail = pokemonData.urlDetail
        newItem.renameCount = 0
        
        do {
            try context.save()
            completion(.success(nil))
        } catch let error {
            completion(.failed(error.localizedDescription))
        }
    }
}
