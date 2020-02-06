//
//  CharactersListPresenter.swift
//  MarvelApp
//
//  Created by Rodrigo Pacheco on 06/02/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import Foundation

class CharactersListPresenter {
    
    var characters: [Character] = []
    
    func loadCharacters(completion: @escaping (Bool) -> Void) {
        let endpoint = MarvelApiEndpoint.characters(offset: 5)
        let marvelApiProvider = MarvelApiProvider()
        
        marvelApiProvider.request(for: endpoint) { [weak self] (result: Result<DataPackage<Character>, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let dataPackage):
                print("sucesso")
                self.characters.append(contentsOf: dataPackage.data.results)
                completion(true)
//                print(self.characters)
            case .failure(let error):
                print("falhou")
                completion(false)
            }
        }
    }
    
    func getCharacters() -> [Character] {
        return characters
    }
}
