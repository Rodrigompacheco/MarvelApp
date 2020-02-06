//
//  CharacterDetailPresenter.swift
//  MarvelApp
//
//  Created by Rodrigo Pacheco on 06/02/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import Foundation

class CharacterDetailPresenter {
    
    let marvelApiProvider: MarvelApiProvider
    let character: Character
    var comics: [Comic] = []

    init(marvelApiProvider: MarvelApiProvider, character: Character) {
        self.marvelApiProvider = marvelApiProvider
        self.character = character
    }
    
    func loadComics(completion: @escaping (Bool) -> Void) {
        
        let endpoint = MarvelApiEndpoint.comics(characterId: character.id, offset: 0)
        
        marvelApiProvider.request(for: endpoint) { [weak self] (result: Result<DataPackage<Comic>, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let dataPackage):
                self.comics.append(contentsOf: dataPackage.data.results)
                completion(true)
            case .failure(let error):
                completion(false)
            }
        }
    }
    
    func getComics() -> [Comic] {
        return comics
    }
    
    func getComicThumbnailImage(at index: Int) -> String {
        guard index < comics.count, let thumbImage = comics[index].thumbnail else { return "" }
        return thumbImage.fullPath
    }
    
    func getCharacterThumbnailImage() -> String {
        return character.thumbnail?.fullPath ?? ""
    }
}
