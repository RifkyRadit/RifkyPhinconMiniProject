//
//  MyPokemonListRepository.swift
//  PhinConPokemon
//
//  Created by Administrator on 11/04/23.
//

import Foundation
import UIKit

enum MyPokemonResult {
    case success(_ dataModel: [MyPokemon])
    case failed(_ errorMessage: String?)
}

protocol MyPokemonListRepositoryData {
    func fetchData(completion: @escaping (MyPokemonResult) -> Void)
    func deleteData(dataItem: MyPokemon, completion: @escaping (MyPokemonResult) -> Void)
    func updateNickname(dataItem: MyPokemon, newNickname: String, completion: @escaping (MyPokemonResult) -> Void)
}

struct MyPokemonListRepository: MyPokemonListRepositoryData {
    
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func fetchData(completion: @escaping (MyPokemonResult) -> Void) {
        guard let context = context else {
            return
        }
        
        do {
            var myPokemon = [MyPokemon]()
            myPokemon = try context.fetch(MyPokemon.fetchRequest())
            completion(.success(myPokemon))
            
        } catch let error {
            completion(.failed(error.localizedDescription))
        }
    }
    
    func deleteData(dataItem: MyPokemon, completion: @escaping (MyPokemonResult) -> Void) {
        guard let context = context else {
            return
        }
        
        context.delete(dataItem)
        do {
            try context.save()
            completion(.success([]))
        } catch let error {
            completion(.failed(error.localizedDescription))
        }
    }
    
    func updateNickname(dataItem: MyPokemon, newNickname: String, completion: @escaping (MyPokemonResult) -> Void) {
        guard let context = context else {
            return
        }
        
        dataItem.pokemonNickname = newNickname
        dataItem.renameCount += 1
        
        do {
            try context.save()
            completion(.success([]))
        } catch let error {
            completion(.failed(error.localizedDescription))
        }
    }
    
}
