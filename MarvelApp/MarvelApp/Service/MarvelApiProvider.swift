//
//  MarvelApiProvider.swift
//  MarvelApp
//
//  Created by Rodrigo Pacheco on 05/02/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import Foundation

final class MarvelApiProvider {
    
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(for endpoint: MarvelApiEndpoint,
                               completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let url = try endpoint.makeUrl()
            
            session.dataTask(with: url) { (data, _, error) in
                guard let data = data else {
                    let newError = error == nil ? MarvelApiError.invalidData : error!
                    completion(.failure(newError))
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                do {
                    let model = try jsonDecoder.decode(T.self, from: data)
                    completion(.success(model))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }
}
