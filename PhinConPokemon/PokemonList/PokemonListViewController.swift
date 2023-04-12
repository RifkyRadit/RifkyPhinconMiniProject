//
//  PokemonListViewController.swift
//  PhinConPokemon
//
//  Created by Administrator on 10/04/23.
//

import UIKit

class PokemonListViewController: UIViewController {

    var dataPokemon = [Pokemon]()
    
    lazy var viewModel: PokemonListViewModel = {
        return PokemonListViewModel()
    }()
    
    lazy var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let list: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        list.translatesAutoresizingMaskIntoConstraints = false
        return list
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refresh: UIRefreshControl = UIRefreshControl()
        refresh.tintColor = UIColor(named: "color_text_activity")
        refresh.translatesAutoresizingMaskIntoConstraints = false
        return refresh
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        handleStateView(state: .showIndicator)
        viewModel.viewDidLoad()
        setupViews()
        setupLayouts()
    }
    
    func setupViews() {
        viewModel.delegate = self
        view.backgroundColor = .white
        view.addSubview(indicatorView)
        view.addSubview(collectionView)
        setupCollectionView()
        indicatorView.hidesWhenStopped = true
    }
    
    func setupLayouts() {
        
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.mainMargin),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin.mainMargin),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Margin.mainMargin)
        ])
    }

    func setupCollectionView() {
        
        collectionView.backgroundColor = .clear
        collectionView.register(PokemonItemCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = collectionViewFlowLayout()
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(actionRefreshControl(_:)), for: .valueChanged)
    }
    
    func collectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.minimumLineSpacing = 8
        flowLayout.scrollDirection = .vertical
        
        return flowLayout
    }
    
    @objc
    func actionRefreshControl(_ sender: UIRefreshControl) {
        sender.endRefreshing()
    }
    
    func handleStateView(state: StateView) {
        switch state {
        case .showIndicator:
            indicatorView.startAnimating()
            indicatorView.isHidden = false
            collectionView.isHidden = true
            
        case .showContent:
            indicatorView.stopAnimating()
            indicatorView.isHidden = true
            collectionView.isHidden = false
            
        default:
            break
        }
    }
}

extension PokemonListViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataPokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PokemonItemCell else {
            return UICollectionViewCell()
        }
        
        let item = self.dataPokemon[indexPath.row]
        guard let name = item.name, let sprites = item.sprites, let imageUrl = sprites.frontDefault else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(name: name, imageUrl: imageUrl)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dataEntire = viewModel.dataEntire[indexPath.row]
        guard let pokemonName = dataEntire.name, let urlString = dataEntire.url else {
            return
        }
        
        let pokemonDetailViewController = PokemonDetailViewController()
        pokemonDetailViewController.title = pokemonName.uppercased()
        pokemonDetailViewController.setUrlSelectedPokemon(url: urlString)
        self.navigationController?.pushViewController(pokemonDetailViewController, animated: true)
    }
}

extension PokemonListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = collectionView.frame.size.height / 3
        return CGSize(width:(collectionView.bounds.width-Margin.minimumMargin) / 2, height: height)
    }
}

extension PokemonListViewController: PokemonListViewModelDelegate {
    func showContent(data: [Pokemon]) {
        DispatchQueue.main.async {
            self.dataPokemon = data
            self.handleStateView(state: .showContent)
            self.collectionView.reloadData()
        }
    }
    
    func failedData(errorMessage: String) {
        DispatchQueue.main.async {
            self.handleStateView(state: .showContent)
            let alert = showAlert(errorMessage: errorMessage)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
