//
//  MainTabBarViewController.swift
//  PhinConPokemon
//
//  Created by Administrator on 11/04/23.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        UITabBar.appearance().backgroundColor = UIColor.white
        tabBar.tintColor = UIColor(named: "color_mainPink")
        setupTabBar()
        setupViewControllers()
//        setupNavbar(viewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "POKEMON"
        setupNavbar(viewController: self)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func setupTabBar() {
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        tabBar.layer.shadowRadius = 2
        tabBar.layer.shadowOpacity = 0.7
        tabBar.layer.masksToBounds = false

    }
    
    func setupViewControllers() {
        let firstViewController = getTabBar(viewController: PokemonListViewController(), image: UIImage(systemName: "house.fill"), title: "Pokemon List", tag: 0)
        let secondViewController = getTabBar(viewController: MyPokemonListViewController(), image: UIImage(systemName: "star.square.fill"), title: "My Pokemon", tag: 1)
        
        viewControllers = [firstViewController, secondViewController]
    }
    
    func getTabBar(viewController: UIViewController,
                             image: UIImage?,
                             title: String,
                             tag: Int) -> UIViewController {
        let vc = viewController
        vc.tabBarItem.image = image?.withRenderingMode(.alwaysTemplate)
        vc.tabBarItem.tag = tag
        vc.tabBarItem.title = title
        
        return vc
    }

}
