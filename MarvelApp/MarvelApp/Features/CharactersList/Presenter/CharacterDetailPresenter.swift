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

    init(marvelApiProvider: MarvelApiProvider, character: Character) {
        self.marvelApiProvider = marvelApiProvider
        self.character = character
    }
    
}
