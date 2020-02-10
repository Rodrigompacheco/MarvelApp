//
//  MarvelAppTests.swift
//  MarvelAppTests
//
//  Created by Rodrigo Pacheco on 05/02/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import XCTest
@testable import MarvelApp

class CharactersListTests: XCTestCase {
    
    var characListPresenter: CharactersListPresenter!
    var charactersMocked: [Character] = []
    //Characters
    let charac1 = Character(id: 0, name: "A.I.M", description: "Terrorist organization.", thumbnail: ThumbImage(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/0", imageExtension: "jpg"))
    let charac2 = Character(id: 1, name: "Real name Franklin Dukes, is a member of the Brotherhood of Mutant Supremacy.", description: "", thumbnail: ThumbImage(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/1", imageExtension: "jpg"))
    let charac3 = Character(id: 2, name: "A.I.M", description: "Terrorist organization.", thumbnail: ThumbImage(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/2", imageExtension: "jpg"))
    
    override func setUp() {
        characListPresenter = CharactersListPresenter(marvelApiProvider: MarvelApiProvider())
        charactersMocked = [charac1, charac2, charac3]
        characListPresenter.characters = charactersMocked
    }

    func testGetCharacters() {
        let presenterCharacList = characListPresenter.getCharacters()
        XCTAssert(charactersMocked == presenterCharacList)
    }
    
    func testCharacterName() {
        let presenterCharacName = characListPresenter.getCharacterName(at: 0)
        XCTAssert(charactersMocked.first?.name == presenterCharacName)
    }
    
    func testCharacterDescription() {
        let presenterCharacDescription = characListPresenter.getCharacterDescription(at: 0)
        XCTAssert(charactersMocked.first?.description == presenterCharacDescription)
    }
    
    func testCharacterThumbnailImage() {
        let presenterCharacThumbnailImage = characListPresenter.getCharacterThumbnailImage(at: 0)
        if let mockThumb = charactersMocked.first?.thumbnail {
            XCTAssert(mockThumb.fullPath == presenterCharacThumbnailImage)
        } 
    }
}
