//
//  EmptyView.swift
//  PhinConPokemon
//
//  Created by Administrator on 12/04/23.
//

import UIKit

class EmptyView: UIView {
    
    lazy var errorImage: UIImageView = {
        let image: UIImageView = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
        setupLayouts()
    }
    
    func setupViews() {
        addSubview(errorImage)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        errorImage.image = UIImage(named: "img_empty_view")
        titleLabel.text = "No Pokemon Caught"
        descriptionLabel.text = "Choose a pokemon first, then try to catch the pokemon, good luck!!"
    }
    
    func setupLayouts() {
        NSLayoutConstraint.activate([
            errorImage.topAnchor.constraint(equalTo: topAnchor, constant: Margin.mainMargin),
            errorImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorImage.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 32) / 2),
            errorImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 3)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: errorImage.bottomAnchor, constant: Margin.mainMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.mainMargin),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Margin.mainMargin)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Margin.minimumMargin),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.mainMargin),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Margin.mainMargin),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Margin.mainMargin)
        ])
    }
    
}
