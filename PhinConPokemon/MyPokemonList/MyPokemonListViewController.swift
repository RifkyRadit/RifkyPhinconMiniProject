//
//  MyPokemonListViewController.swift
//  PhinConPokemon
//
//  Created by Administrator on 11/04/23.
//

import UIKit

class MyPokemonListViewController: UIViewController {

    var dataMyPokemon: [MyPokemon] = []
    
    lazy var viewModel: MyPokemonListViewModel = {
        return MyPokemonListViewModel()
    }()
    
    lazy var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var emptyView: EmptyView = {
        let view = EmptyView()
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
        setupViews()
        setupLayouts()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(indicatorView)
        view.addSubview(emptyView)
        view.addSubview(collectionView)
        setupCollectionView()
        indicatorView.hidesWhenStopped = true
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewDidLoad()
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
        
        NSLayoutConstraint.activate([
            emptyView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
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
        viewModel.viewDidLoad()
        sender.endRefreshing()
    }
    
    func handleStateView(state: StateView) {
        switch state {
        case .showIndicator:
            indicatorView.startAnimating()
            indicatorView.isHidden = false
            collectionView.isHidden = true
            emptyView.isHidden = true
            
        case .showContent:
            indicatorView.stopAnimating()
            indicatorView.isHidden = true
            collectionView.isHidden = false
            emptyView.isHidden = true
            
        case .showEmptyState:
            indicatorView.stopAnimating()
            indicatorView.isHidden = true
            collectionView.isHidden = true
            emptyView.isHidden = false
        }
    }
}

extension MyPokemonListViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataMyPokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PokemonItemCell else {
            return UICollectionViewCell()
        }
        
        let itemData = self.dataMyPokemon[indexPath.row]
        guard let nickname = itemData.pokemonNickname, let imageUrl = itemData.pokemonUrlImage else {
            return UICollectionViewCell()
        }

        cell.configureCell(name: nickname, imageUrl: imageUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPokemon = self.dataMyPokemon[indexPath.row]
        let selectedPokemonNickname = selectedPokemon.pokemonNickname ?? ""
        
        let actionSheet = UIAlertController(title: "Action for Your Pokemon " + selectedPokemonNickname, message: "You can rename the nickname of pokemon or release the pokemon", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Change Nickname", style: .default, handler: { [weak self] _ in
            self?.viewModel.renamePokemon(data: selectedPokemon)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Release Pokemon", style: .default, handler: { [weak self] _ in
            self?.viewModel.deleteMyPokemon(data: selectedPokemon)
        }))
        actionSheet.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
}

extension MyPokemonListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = collectionView.frame.size.height / 3
        return CGSize(width:(collectionView.bounds.width-Margin.minimumMargin)/2, height: height)
    }
}

extension MyPokemonListViewController: MyPokemonListViewModelDelegate {

    func showContent(data: [MyPokemon]) {
        DispatchQueue.main.async {
            self.dataMyPokemon = data
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
            self.handleStateView(state: .showContent)
        }
    }
    
    func failedData(errorMessage: String) {
        DispatchQueue.main.async {
            self.handleStateView(state: .showContent)
            let alert = showAlert(errorMessage: errorMessage)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func emptyData() {
        DispatchQueue.main.async {
            self.handleStateView(state: .showEmptyState)
        }
    }
}
