//
//  ButtonView.swift
//  PhinConPokemon
//
//  Created by Administrator on 11/04/23.
//

import Foundation
import UIKit

protocol ButtonViewDelegate: AnyObject {
    func didTapNextButton()
}

class ButtonView: UIView {
    
    // MARK: - Properties
    weak var delegate: ButtonViewDelegate?
    
    // MARK: - Components
    lazy var catchButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "color_mainPink")
        button.tintColor = UIColor.white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        backgroundColor = .white
        addSubview(catchButton)
        
        catchButton.setTitle("Catch Pokemon", for: .normal)
        catchButton.addTarget(self, action: #selector(catchButtonAction(_:)), for: .touchUpInside)
        catchButton.layer.cornerRadius = 4
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            catchButton.topAnchor.constraint(equalTo: topAnchor, constant: Margin.mainMargin),
            catchButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.mainMargin),
            catchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Margin.mainMargin),
            catchButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Margin.mainMargin),
            catchButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc
    func catchButtonAction(_ sender: UIButton) {
        guard let delegate = delegate else {
            return
        }
        
        delegate.didTapNextButton()
    }
    
}
