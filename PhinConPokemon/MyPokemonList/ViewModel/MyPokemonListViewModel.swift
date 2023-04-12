//
//  MyPokemonListViewModel.swift
//  PhinConPokemon
//
//  Created by Administrator on 11/04/23.
//

import Foundation

protocol MyPokemonListViewModelDelegate: AnyObject {
    func showContent(data: [MyPokemon])
    func failedData(errorMessage: String)
    func emptyData()
}

protocol MyPokemonListViewModelInput {
    func viewDidLoad()
}

class MyPokemonListViewModel: MyPokemonListViewModelInput {
    
    let myPokemonListRepository = MyPokemonListRepository()
    
    weak var delegate: MyPokemonListViewModelDelegate?
    
    func viewDidLoad(){
        fetchDataMyPokemon()
    }
    
    func fetchDataMyPokemon() {
        myPokemonListRepository.fetchData { result in
            switch result {
            case .success(let data):
                
                guard !data.isEmpty, let delegate = self.delegate else {
                    self.delegate?.emptyData()
                    return
                }
                
                delegate.showContent(data: data)
                
            case .failed:
                self.showError(message: "Sorry, Failed Proses")
            }
        }
    }
    
    func deleteMyPokemon(data: MyPokemon) {
        let randomNumber = Int.random(in: 0...100)
        
        guard checkIsPrimeNumber(number: randomNumber) == true else {
            self.showError(message: "Release fail, because the number isn't prime. Try Again!")
            return
        }
        
        myPokemonListRepository.deleteData(dataItem: data) { result in
            switch result {
            case .success:
                self.fetchDataMyPokemon()

            case .failed:
                self.showError(message: "Sorry, Failed Proses")
            }
        }
    }
    
    func checkIsPrimeNumber(number: Int) -> Bool {
        var isPrimeNumber: Bool = true
        
        if number <= 1 {
            return isPrimeNumber
        } else {
            
            for i in 2 ..< number {
                if number % i == 0 {
                    isPrimeNumber = false
                    break
                }
            }
            return isPrimeNumber
        }
        
    }
    
    func renamePokemon(data: MyPokemon) {
        
        var newNickname: String = ""
        var intNickname: Int = 0
        guard let nickname = data.pokemonNickname else {
            return
        }
        
        for i in 0...Int(data.renameCount) {
            intNickname = getFibonacciNumber(num: i)
        }
        
        let numericOnNickname = numericsOnly(nickname)
        if !numericOnNickname.isEmpty {
            newNickname = nickname.replacingOccurrences(of: numericOnNickname, with: String(intNickname))

        } else {
            newNickname = [nickname, String(intNickname)].joined(separator: "-")
        }
        
        myPokemonListRepository.updateNickname(dataItem: data, newNickname: newNickname) { result in
            switch result {
            case .success:
                self.fetchDataMyPokemon()
                
            case .failed:
                self.showError(message: "Sorry, Failed Proses")
            }
        }
    }
    
    func getFibonacciNumber(num: Int) -> Int{
       var number1 = 0
       var number2 = 1
       var nR = 0
       
       for _ in 0..<num{
          nR = number1
          number1 = number2
          number2 = nR + number2
       }
        
       return number1
    }
    
    func showError(message: String) {
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.failedData(errorMessage: message)
    }
    
    func numericsOnly(_ text: String) -> String {
        return text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
    }
}
