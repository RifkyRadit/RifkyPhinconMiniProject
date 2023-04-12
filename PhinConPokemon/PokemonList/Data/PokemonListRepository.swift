//
//  PokemonListRepository.swift
//  PhinConPokemon
//
//  Created by Administrator on 10/04/23.
//

import UIKit

enum EntireResult {
    case success(_ dataModel: [PokemonEntireData]?)
    case failed(_ errorMessage: String?)
}

enum PokemonResult {
    case success(_ dataModel: [Pokemon]?)
    case failed(_ errorMessage: String?)
}

protocol PokemonListRepositoryData {
    func getDataEntirePokemon(completion: @escaping (EntireResult) -> Void)
    func getDetailDataListPokemon(dataPokemons: [PokemonEntireData], completion: @escaping (PokemonResult) -> Void)
}

struct PokemonListRepository: PokemonListRepositoryData {
    
    
    func getDataEntirePokemon(completion: @escaping (EntireResult) -> Void) {
        let urlString = "https://pokeapi.co/api/v2/pokemon?limit=20"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                completion(.failed(error?.localizedDescription))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let object = try jsonDecoder.decode(PokemonEntire.self, from: data)
                completion(.success(object.results))
                
            } catch let error {
                completion(.failed(error.localizedDescription))
            }
            
            
        }.resume()
    }
    
    func getDetailDataListPokemon(dataPokemons: [PokemonEntireData], completion: @escaping (PokemonResult) -> Void) {
        let group = DispatchGroup()
        var arrDataPokemon: [Pokemon] = []
        var errorProsses: Error?
        
        for dataPokemon in dataPokemons {
            group.enter()
            guard let urlString = dataPokemon.url, let url = URL(string: urlString) else {
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                guard let data = data else {
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                do {
                    let object = try jsonDecoder.decode(Pokemon.self, from: data)
                    arrDataPokemon.append(object)
                    group.leave()
                } catch let error {
                    errorProsses = error
                    group.leave()
                }
            }.resume()
        }
        
        group.notify(queue: .main) {
            if errorProsses != nil {
                completion(.failed(errorProsses?.localizedDescription))
            } else {
                completion(.success(arrDataPokemon))
            }
        }
        
    }
}
