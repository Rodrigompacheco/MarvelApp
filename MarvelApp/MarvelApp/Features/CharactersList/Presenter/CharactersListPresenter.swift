//
//  CharactersListPresenter.swift
//  MarvelApp
//
//  Created by Rodrigo Pacheco on 06/02/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import Foundation

protocol CharactersListPresenterViewDelegate: class {
    func reloadData()
}

protocol CharactersListPresenterCoordinatorDelegate: class {
    func didSelectCharacter(character: Character)
}

class CharactersListPresenter {
    
    let marvelApiProvider: MarvelApiProvider
    var characters: [Character] = []
    let pagination: Pagination<Character>
    
    weak var presenterViewDelegate: CharactersListPresenterViewDelegate?
    weak var presenterCoordinatorDelegate: CharactersListPresenterCoordinatorDelegate?

    init(marvelApiProvider: MarvelApiProvider) {
        self.marvelApiProvider = marvelApiProvider
        self.pagination = Pagination()
    }
    
    func loadCharacters(completion: @escaping (DataState) -> Void) {
        pagination.isLoading = true
        
        let endpoint = MarvelApiEndpoint.characters(offset: pagination.offset)
        
        self.marvelApiProvider.request(for: endpoint) { [weak self] (result: Result<DataPackage<Character>, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let dataPackage):
                let changeState = self.pagination.paginate(dataPackage: dataPackage)
                self.characters = self.pagination.results
                completion(changeState)
            case .failure(_):
                completion(.error(.invalidData))
            }
        }
    }
    
    func getCharacters() -> [Character] {
        return characters
    }
    
    func getCharacterName(at index: Int) -> String {
        guard index < characters.count else { return "" }
        return characters[index].name
    }
    
    func getCharacterDescription(at index: Int) -> String {
        guard index < characters.count else { return "" }
        return characters[index].description
    }
    
    func getCharacterThumbnailImage(at index: Int) -> String {
        guard index < characters.count, let thumbImage = characters[index].thumbnail else { return "" }
        return thumbImage.fullPath
    }
    
    func hasMoreToDownload() -> Bool {
        return pagination.hasMore
    }
}

extension CharactersListPresenter: CharactersListViewControllerDelegate {
    func didSelectCell(at index: Int) {
        let character = characters[index]
        presenterCoordinatorDelegate?.didSelectCharacter(character: character)
    }
}
