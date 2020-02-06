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
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func start() {
        let presenter = CharactersListPresenter(marvelApiProvider: marvelApiProvider)
        presenter.presenterCoordinatorDelegate = self
        let viewController = CharactersListViewController(presenter: presenter)
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension MainCoordinator: CharactersListPresenterCoordinatorDelegate {
    func didSelectCharacter(character: Character) {
        let presenter = CharacterDetailPresenter(marvelApiProvider: marvelApiProvider, character: character)

//        let viewController = CharacterDetailViewController(viewModel: viewModel)
//        navigationController.pushViewController(viewController, animated: true)
        print("VAI IR PRA DEITAIL VIEW CONTROLLER")
    }
}
