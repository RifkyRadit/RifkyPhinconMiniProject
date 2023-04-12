//
//  PokemonProfileView.swift
//  PhinConPokemon
//
//  Created by Administrator on 12/04/23.
//

import Foundation
import UIKit

protocol PokemonProfileViewInput {
    func setProfilePokemon(name: String, height: Int, weight: Int)
}

class PokemonProfileView: UIView {
    
    // MARK: - Component
    lazy var pokemonNameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var pokemonHeightLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var pokemonWeightLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Default init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
        setupLayout()
    }
    
    // MARK: - Setup
    func setupViews() {
        addSubview(pokemonNameLabel)
        addSubview(pokemonHeightLabel)
        addSubview(pokemonWeightLabel)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            pokemonNameLabel.topAnchor.constraint(equalTo: topAnchor),
            pokemonNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            pokemonNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            pokemonHeightLabel.topAnchor.constraint(equalTo: pokemonNameLabel.bottomAnchor, constant: Margin.minimumMargin),
            pokemonHeightLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            pokemonWeightLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            pokemonWeightLabel.topAnchor.constraint(equalTo: pokemonHeightLabel.bottomAnchor, constant: Margin.minimumMargin),
            pokemonWeightLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            pokemonWeightLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            pokemonWeightLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension PokemonProfileView: PokemonProfileViewInput {
    func setProfilePokemon(name: String, height: Int, weight: Int) {
        pokemonNameLabel.text = "Name: " + name
        pokemonHeightLabel.text = "Height: " + String(height)
        pokemonWeightLabel.text = "Weight: " + String(weight)
    }
}
