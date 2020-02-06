//
//  CharactersListPresenter.swift
//  MarvelApp
//
//  Created by Rodrigo Pacheco on 06/02/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import Foundation

protocol CharactersListPresenterDelegate: class {
    func reloadData()
}

class CharactersListPresenter {
    
    var characters: [Character] = []
    
    weak var delegate: CharactersListPresenterDelegate?
    
    private func loadCharacters(completion: @escaping (Bool) -> Void) {
        let endpoint = MarvelApiEndpoint.characters(offset: 0)
        let marvelApiProvider = MarvelApiProvider()
        
        marvelApiProvider.request(for: endpoint) { [weak self] (result: Result<DataPackage<Character>, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let dataPackage):
                print("sucesso")
                self.characters.append(contentsOf: dataPackage.data.results)
                completion(true)
            case .failure(let error):
                print("falhou")
                completion(false)
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
}

extension CharactersListPresenter: CharactersListViewControllerDelegate {
    func didSelectCell(at index: Int) {
        print(index)
    }
    
    func setupView() {
        loadCharacters(completion: { result in
            if result {
                self.delegate?.reloadData()
            }
        })
    }
}
