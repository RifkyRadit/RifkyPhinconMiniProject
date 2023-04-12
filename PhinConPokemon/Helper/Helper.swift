//
//  Helper.swift
//  PhinConPokemon
//
//  Created by Administrator on 11/04/23.
//

import UIKit

func showAlert(errorMessage: String) -> UIAlertController {
    let alert = UIAlertController(title: "", message: errorMessage, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    return alert
}

func setupNavbar(viewController: UIViewController) {
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = UIColor(named: "color_mainPink")
    appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    viewController.navigationController?.navigationBar.backgroundColor = UIColor(named: "color_mainPink")
    viewController.navigationController?.navigationBar.tintColor = .white
    viewController.navigationController?.navigationBar.standardAppearance = appearance
    viewController.navigationController?.navigationBar.compactAppearance = appearance
    viewController.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    viewController.navigationController?.navigationBar.barTintColor = UIColor(named: "color_mainPink")
}
