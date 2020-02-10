//
//  CharacterDetails.swift
//  MarvelAppTests
//
//  Created by Rodrigo Pacheco on 10/02/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import XCTest
@testable import MarvelApp

class CharacterDetailsTests: XCTestCase {

    var characterDetailPresenter: CharacterDetailPresenter!
    var comicsMocked: [Comic] = []
    var characterMocked: Character!
    //Comics
    let comic1: Comic = Comic(id: 01, thumbnail: ThumbImage(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/01", imageExtension: "jpg"))
    let comic2: Comic = Comic(id: 11, thumbnail: ThumbImage(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/11", imageExtension: "jpg"))
    let comic3: Comic = Comic(id: 21, thumbnail: ThumbImage(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/21", imageExtension: "jpg"))

    override func setUp() {
        characterMocked = Character(id: 0, name: "A.I.M", description: "Terrorist organization.", thumbnail: ThumbImage(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/0", imageExtension: "jpg"))
        characterDetailPresenter = CharacterDetailPresenter(marvelApiProvider: MarvelApiProvider(), character: characterMocked)
        comicsMocked = [comic1, comic2, comic3]
        characterDetailPresenter.comics = comicsMocked
    }

    func testExample() {
        let presenterCharacComics = characterDetailPresenter.getComics()
        XCTAssert(comicsMocked == presenterCharacComics)
    }
    
    func testCharacterThumbnailImage() {
        let presenterThumbnailImage = characterDetailPresenter.getCharacterThumbnailImage()
        XCTAssert(characterMocked.thumbnail?.fullPath == presenterThumbnailImage)
    }
    
    func testComicThumbnailImage() {
           let presenterComicThumbnailImage = characterDetailPresenter.getComicThumbnailImage(at: 0)
           if let thumbMocked = comicsMocked.first?.thumbnail {
            XCTAssert(thumbMocked.fullPath == presenterComicThumbnailImage)
           }
       }
}
