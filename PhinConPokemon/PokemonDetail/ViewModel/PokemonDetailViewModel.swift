//
//  PokemonDetailViewModel.swift
//  PhinConPokemon
//
//  Created by Administrator on 11/04/23.
//

import Foundation


protocol PokemonDetailViewModelDelegate: AnyObject {
    func showContent(data: PokemonDetail?)
    func successSaveData()
    func failedProcess()
}

protocol PokemonDetailViewModelInput {
    func viewDidLoad(withUrl url: String)
}

class PokemonDetailViewModel: PokemonDetailViewModelInput {
    
    let pokemonDetailRepository = PokemonDetailRepository()
    var dataDetail: PokemonDetail?
    weak var delegate: PokemonDetailViewModelDelegate?
    
    func viewDidLoad(withUrl url: String) {
        getDetailPokemon(urlString: url)
    }
    
    func getDetailPokemon(urlString: String) {
        pokemonDetailRepository.getDetailPokemon(url: urlString) { result in
            switch result {
            case .success(let data):
                
                guard let delegate = self.delegate else {
                    self.showError()
                    return
                }
                
                self.dataDetail = data
                delegate.showContent(data: self.dataDetail)
                
            case .failed:
                self.showError()
            }
        }
    }
    
    func addCaughtPokemon(withData dataPokemon: CatchPokemon) {
        pokemonDetailRepository.saveData(pokemonData: dataPokemon) { result in
            switch result {
            case .success:
                
                guard let delegate = self.delegate else {
                    self.showError()
                    return
                }
                
                delegate.successSaveData()
                
            case .failed:
                self.showError()
            }
        }
    }
    
    func showError() {
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.failedProcess()
    }
    
}
