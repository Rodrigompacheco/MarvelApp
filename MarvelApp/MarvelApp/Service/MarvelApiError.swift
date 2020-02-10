//
//  MarvelApiError.swift
//  MarvelApp
//
//  Created by Rodrigo Pacheco on 05/02/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import Foundation

enum MarvelApiError: Error {
    case custom(String)
}

extension MarvelApiError {
    static var makeRequest: MarvelApiError {
        return MarvelApiError.custom("Couldn't create request.")
    }
    
    static var decode: MarvelApiError {
        return MarvelApiError.custom("Couldn't decode data.")
    }
    
    static var invalidURL: MarvelApiError {
        return MarvelApiError.custom("Invalid URL.")
    }
    
    static var invalidData: MarvelApiError {
           return MarvelApiError.custom("Invalid Data.")
    }
}
