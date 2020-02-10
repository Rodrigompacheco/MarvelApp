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

enum DataState {
    case notLoaded
    case loading
    case initial
    case inserted([IndexPath])
    case error(MarvelApiError)
}

final class Pagination<T> where T: Decodable {
    var hasMore = true
    var isLoading = false
    var offset = 0
    var results: [T] = []
    
    func paginate(dataPackage: DataPackage<T>) -> DataState {
        self.results += dataPackage.data.results
        let indexPaths = (self.offset..<self.results.count).map { IndexPath(row: $0, section: 0) }
        let changeState: DataState = self.offset == 0 ? .initial : .inserted(indexPaths)
        self.offset += dataPackage.data.count
        self.hasMore = self.results.count < dataPackage.data.total
        self.isLoading = false
        return changeState
    }
}
