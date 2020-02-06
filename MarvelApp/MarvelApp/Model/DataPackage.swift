//
//  DataPackage.swift
//  MarvelApp
//
//  Created by Rodrigo Pacheco on 05/02/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import Foundation

struct DataPackage<T>: Decodable where T: Decodable {
    let data: DataContainer<T>
}

struct DataContainer<T>: Decodable where T: Decodable  {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [T]
}
