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
    let pagination: Pagination<Comic>
    var comics: [Comic] = []

    init(marvelApiProvider: MarvelApiProvider, character: Character) {
        self.marvelApiProvider = marvelApiProvider
        self.character = character
        self.pagination = Pagination()
    }
    
    func loadComics(completion: @escaping (DataState) -> Void) {
        
        let endpoint = MarvelApiEndpoint.comics(characterId: character.id, offset: pagination.offset)
        
        marvelApiProvider.request(for: endpoint) { [weak self] (result: Result<DataPackage<Comic>, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let dataPackage):
                let dataState = self.pagination.paginate(dataPackage: dataPackage)
                self.comics = self.pagination.results
                completion(dataState)
            case .failure(_):
                completion(.error(.invalidData))
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
    
    func hasMoreToDownload() -> Bool {
        return pagination.hasMore
    }
}
