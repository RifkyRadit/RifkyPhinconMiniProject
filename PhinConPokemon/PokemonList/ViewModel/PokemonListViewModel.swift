//
//  PokemonListViewModel.swift
//  PhinConPokemon
//
//  Created by Administrator on 11/04/23.
//

import Foundation

protocol PokemonListViewModelDelegate: AnyObject {
    func showContent(data: [Pokemon])
    func failedData(errorMessage: String)
}

protocol PokemonListViewModelInput {
    func viewDidLoad()
}

class PokemonListViewModel: PokemonListViewModelInput {
    
    let pokemonListRepository = PokemonListRepository()
    var dataEntire = [PokemonEntireData]()
    
    weak var delegate: PokemonListViewModelDelegate?
    
    func viewDidLoad(){
        getEntirePokemon()
        getDataListPokemon()
    }
    
    func getEntirePokemon() {
        pokemonListRepository.getDataEntirePokemon { result in
            switch result {
            case .success(let dataEntirePokemon):
                guard let dataEntirePokemon = dataEntirePokemon else {
                    return
                }
                
                self.dataEntire = dataEntirePokemon
                
            case .failed:
                self.showError(message: "Sorry, Failed Proses")
            }
        }
    }
    
    func getDataListPokemon() {
        DispatchQueue.main.async {
            guard !self.dataEntire.isEmpty else {
                return
            }
            
            self.pokemonListRepository.getDetailDataListPokemon(dataPokemons: self.dataEntire) { result in
                switch result {
                case .success(let pokemon):
                    
                    guard let pokemon = pokemon, let delegate = self.delegate else {
                        return
                    }
                    
                    delegate.showContent(data: pokemon)
                    
                case .failed:
                    self.showError(message: "Sorry, Failed Proses")
                }
            }
        }
    }
    
    func showError(message: String) {
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.failedData(errorMessage: message)
    }
}
