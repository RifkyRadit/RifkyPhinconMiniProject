//
//  ChipView.swift
//  PhinConPokemon
//
//  Created by Administrator on 11/04/23.
//

import Foundation
import UIKit

protocol ChipViewInput {
    func setTitle(titleName: String)
    func setChipName(arrName: [String])
}

class ChipView: UIView {
    
    private var dataContents: [String] = [] {
        didSet {
            self.reloadData()
        }
    }
    
//    lazy var chipContainerView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .systemGroupedBackground
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "Pokemon Name"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let list: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        list.translatesAutoresizingMaskIntoConstraints = false
        return list
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
    
    func setupViews() {
        addSubview(titleLabel)
//        addSubview(chipContainerView)
        addSubview(collectionView)
        setupCollectionView()
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
//        NSLayoutConstraint.activate([
//            chipContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Margin.minimumMargin),
//            chipContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            chipContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            chipContainerView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Margin.minimumMargin),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.register(ChipItemCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = collectionViewFlowLayout()
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        collectionView.layer.cornerRadius = 8
    }
    
    func collectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.minimumLineSpacing = 8
        flowLayout.scrollDirection = .vertical
        
        return flowLayout
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension ChipView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataContents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ChipItemCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(name: self.dataContents[indexPath.row])
        return cell
    }
}

extension ChipView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = collectionView.frame.size.height / 4
        return CGSize(width:(collectionView.bounds.width-Margin.minimumMargin)/5, height: height)
    }
}

extension ChipView: ChipViewInput {
    func setTitle(titleName: String) {
        self.titleLabel.text = titleName
    }
    
    func setChipName(arrName: [String]) {
//        DispatchQueue.main.async {
            self.dataContents = arrName
//            self.collectionView.reloadData()
//        }
    }
}

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
}
