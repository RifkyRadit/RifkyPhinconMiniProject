//
//  PokemonDetailViewController.swift
//  PhinConPokemon
//
//  Created by Administrator on 11/04/23.
//

import UIKit

protocol PokemonDetailViewControllerInput: AnyObject {
    func setUrlSelectedPokemon(url: String)
}

class PokemonDetailViewController: UIViewController {

    private var urlDetailPokemon: String = ""
    
    private var dataPokemon: PokemonDetail? = nil {
        didSet {
            setupPokemonImage()
            setupPokemonMoves()
            setupPokemonTypes()
            setupPokemonProfile()
        }
    }
    
    lazy var viewModel: PokemonDetailViewModel = {
        return PokemonDetailViewModel()
    }()
    
    lazy var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "img_placeholder")
        imageView.backgroundColor = .systemGroupedBackground
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var profileView: PokemonProfileView = {
        let view = PokemonProfileView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var movesChipView: ChipView = {
        let view = ChipView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var typesChipView: ChipView = {
        let view = ChipView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var buttonView: ButtonView = {
        let view = ButtonView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar(viewController: self)
        handleStateView(state: .showIndicator)
        setupViews()
        setupLayouts()
        viewModel.viewDidLoad(withUrl: self.urlDetailPokemon)
    }
    
    func setupViews() {
        viewModel.delegate = self
        buttonView.delegate = self
        
        view.backgroundColor = .white
        view.addSubview(contentView)
        contentView.addSubview(pokemonImageView)
        contentView.addSubview(profileView)
        contentView.addSubview(movesChipView)
        contentView.addSubview(typesChipView)
        view.addSubview(buttonView)
        view.addSubview(indicatorView)
        
        indicatorView.hidesWhenStopped = true
        
        pokemonImageView.layer.cornerRadius = 4
        pokemonImageView.clipsToBounds = true
        
        buttonView.layer.shadowColor = UIColor.black.cgColor
        buttonView.layer.shadowOpacity = 0.1
        buttonView.layer.shadowOffset = CGSize(width: 0, height: -2)
        buttonView.layer.shadowRadius = 1.0
    }
    
    func setupLayouts() {
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: buttonView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            pokemonImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Margin.mainMargin),
            pokemonImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margin.mainMargin),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 100),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 110)
        ])
        
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: pokemonImageView.topAnchor, constant: Margin.minimumMargin),
            profileView.leadingAnchor.constraint(equalTo: pokemonImageView.trailingAnchor, constant: Margin.minimumMargin),
            profileView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margin.mainMargin)
        ])
        
        NSLayoutConstraint.activate([
            movesChipView.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: Margin.maximumMargin),
            movesChipView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margin.mainMargin),
            movesChipView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margin.mainMargin)
        ])
        
        NSLayoutConstraint.activate([
            typesChipView.topAnchor.constraint(equalTo: movesChipView.bottomAnchor, constant: Margin.maximumMargin),
            typesChipView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margin.mainMargin),
            typesChipView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margin.mainMargin),
        ])
        
        NSLayoutConstraint.activate([
            buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func handleStateView(state: StateView) {
        switch state {
        case .showIndicator:
            indicatorView.startAnimating()
            indicatorView.isHidden = false
            contentView.isHidden = true
            buttonView.isHidden = true
            
        case .showContent:
            indicatorView.stopAnimating()
            indicatorView.isHidden = true
            contentView.isHidden = false
            buttonView.isHidden = false
            
        default:
            break
        }
    }

    func setupPokemonImage() {
        guard let dataPokemon = dataPokemon, let sprites = dataPokemon.sprites, let urlImage = sprites.frontDefault else {
            return
        }

        pokemonImageView.loadImage(urlString: urlImage, PlaceHolderImage: UIImage(named: "img_placeholder")!)
    }
    
    func setupPokemonProfile() {
        guard let dataPokemon = dataPokemon, let name = dataPokemon.name, let weight = dataPokemon.weight, let height = dataPokemon.height else {
            return
        }
        
        profileView.setProfilePokemon(name: name, height: height, weight: weight)
    }
    
    func setupPokemonMoves() {
        guard let dataPokemon = dataPokemon, let moves = dataPokemon.moves else {
            return
        }
        
        var arrMoves: [String] = []
        
        moves.forEach { itemMove in
            guard let moveName = itemMove.move?.name else {
                return
            }
            
            arrMoves.append(moveName)
        }
        
        movesChipView.setTitle(titleName: "Pokemon Moves")
        movesChipView.setChipName(arrName: arrMoves)
    }
    
    func setupPokemonTypes() {
        guard let dataPokemon = dataPokemon, let types = dataPokemon.types else {
            return
        }
        
        var arrTypes: [String] = []
        
        types.forEach { itemType in
            guard let typeName = itemType.type?.name else {
                return
            }
            
            arrTypes.append(typeName)
        }

        typesChipView.setTitle(titleName: "Pokemon Types")
        typesChipView.setChipName(arrName: arrTypes)
    }
}

extension PokemonDetailViewController: PokemonDetailViewControllerInput {
    func setUrlSelectedPokemon(url: String) {
        self.urlDetailPokemon = url
    }
}

extension PokemonDetailViewController: PokemonDetailViewModelDelegate {
    func successSaveData() {
        DispatchQueue.main.async {
            let alert = showAlert(errorMessage: "You Success catch The Pokemon")
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func failedProcess() {
        DispatchQueue.main.async {
            let alert = showAlert(errorMessage: "Sorry, Something wrong")
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showContent(data: PokemonDetail?) {
        DispatchQueue.main.async {
            self.dataPokemon = data
            self.handleStateView(state: .showContent)
        }
    }
}

extension PokemonDetailViewController: ButtonViewDelegate {
    func didTapNextButton() {
        let alert = UIAlertController(title: "New Nickname", message: "Insert for Pokemon Nickname", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self] _ in
           
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty, let dataPokemon = self?.dataPokemon else {
                return
            }
            
            let data = CatchPokemon(id: Int32(dataPokemon.id ?? 0), name: dataPokemon.name, nickname: text, imageUrl: dataPokemon.sprites?.frontDefault, urlDetail: self?.urlDetailPokemon)
            self?.viewModel.addCaughtPokemon(withData: data)
        }))
        present(alert, animated: true, completion: nil)
    }
}
