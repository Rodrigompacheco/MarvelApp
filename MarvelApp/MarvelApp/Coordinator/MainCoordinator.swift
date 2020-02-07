//
//  File.swift
//  MarvelApp
//
//  Created by Rodrigo Pacheco on 06/02/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let marvelApiProvider: MarvelApiProvider = MarvelApiProvider()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
//        self.navigationController.setNavigationBarHidden(true, animated: false)
        
        navigationController.navigationBar.prefersLargeTitles = false
//        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.barTintColor = UIColor(red: 220/255, green: 55/255, blue: 48/255, alpha: 1.0)
        navigationController.navigationBar.tintColor = .white
    }
    
    func start() {
        let presenter = CharactersListPresenter(marvelApiProvider: marvelApiProvider)
        presenter.presenterCoordinatorDelegate = self
        let viewController = CharactersListViewController(presenter: presenter)
        viewController.title = "Characters"
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension MainCoordinator: CharactersListPresenterCoordinatorDelegate {
    func didSelectCharacter(character: Character) {
        let presenter = CharacterDetailPresenter(marvelApiProvider: marvelApiProvider, character: character)

        let viewController = CharacterDetailViewController(presenter: presenter)
        viewController.title = character.name
        navigationController.pushViewController(viewController, animated: true)
    }
}
