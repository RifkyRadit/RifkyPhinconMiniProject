//
//  ChipItemCell.swift
//  PhinConPokemon
//
//  Created by Administrator on 12/04/23.
//

import UIKit

class ChipItemCell: UICollectionViewCell {
    
    // MARK: - Components
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = ""
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
        backgroundColor = .systemBlue
        
        addSubview(nameLabel)
        
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }
    
    // MARK: - Setup
    private func setupLayout() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.minimumMargin),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Margin.minimumMargin),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configureCell(name: String) {
        self.nameLabel.text = name
    }
}
