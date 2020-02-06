//
//  MarvelConfig.swift
//  MarvelApp
//
//  Created by Rodrigo Pacheco on 05/02/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import Foundation

struct MarvelApiConfig {
    static let privateKey = "390fab05c056f0729e0284abc30ac8592eef91a2"
    static let publicKey = "3470c2f1697747c66eb29ce9faeab390"
    static let time = Date().timeIntervalSince1970.description
    static let hash: String = "\(time)\(privateKey)\(publicKey)".md5()
    
    static func asURLQueryitems() -> [URLQueryItem] {
        return [
            URLQueryItem(name: "apikey", value: MarvelApiConfig.publicKey),
            URLQueryItem(name: "ts", value: MarvelApiConfig.time),
            URLQueryItem(name: "hash", value: MarvelApiConfig.hash)
        ]
    }
}
