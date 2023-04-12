//
//  PokemonItemCell.swift
//  PhinConPokemon
//
//  Created by Administrator on 10/04/23.
//

import UIKit

class PokemonItemCell: UICollectionViewCell {
    
    // MARK: - Components
    lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "img_placeholder")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nameContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "color_mainPink")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "Pokemon Name"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
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
    
    private func setupViews() {
        backgroundColor = .systemGroupedBackground
        
        nameContainerView.addSubview(nameLabel)
        addSubview(pokemonImageView)
        addSubview(nameContainerView)
        
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }
    
    // MARK: - Setup
    private func setupLayout() {
        NSLayoutConstraint.activate([
            pokemonImageView.topAnchor.constraint(equalTo: topAnchor),
            pokemonImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pokemonImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pokemonImageView.heightAnchor.constraint(equalToConstant: self.bounds.height - 32)
        ])
        
        NSLayoutConstraint.activate([
            nameContainerView.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor),
            nameContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            nameContainerView.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: nameContainerView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: nameContainerView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: nameContainerView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: nameContainerView.bottomAnchor)
        ])
    }
    
    func configureCell(name: String, imageUrl: String) {
        DispatchQueue.main.async {
            
            self.nameLabel.text = name
            self.pokemonImageView.loadImage(urlString: imageUrl, PlaceHolderImage: UIImage(named: "img_placeholder")!)
        }
    }
}
