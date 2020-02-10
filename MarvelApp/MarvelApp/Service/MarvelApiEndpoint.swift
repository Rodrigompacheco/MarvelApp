//
//  MarvelApiEndpoint.swift
//  MarvelApp
//
//  Created by Rodrigo Pacheco on 05/02/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import Foundation

enum MarvelApiEndpoint {
    case characters(offset: Int)
    case comics(characterId: Int, offset: Int)
}

extension MarvelApiEndpoint {
    static let baseUrl = "https://gateway.marvel.com:443"
    
    var path: String {
        switch self {
        case .characters:
            return "/v1/public/characters"
        case .comics(let characterId, _):
            return "/v1/public/characters/\(characterId)/comics"
        }
    }
    
    var queryItems: [URLQueryItem] {
        var queryItems: [URLQueryItem] = MarvelApiConfig.asURLQueryitems()
        switch self {
        case .characters(let offset), .comics(_, let offset):
            queryItems.append(URLQueryItem(name: "offset", value: offset.description))
        }
        return queryItems
    }
    
    func makeUrl() throws -> URL {
        var components = URLComponents(string: MarvelApiEndpoint.baseUrl + path)
        components?.queryItems = queryItems
        
        guard let url = components?.url else {
            throw MarvelApiError.invalidURL
        }
        
        return url
    }
    
}
