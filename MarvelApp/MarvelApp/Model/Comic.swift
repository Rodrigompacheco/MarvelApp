//
//  Comic.swift
//  MarvelApp
//
//  Created by Rodrigo Pacheco on 05/02/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import Foundation

struct Comic: Codable {
    let id: Int
    let thumbnail: ThumbImage?
    
    enum CodingKeys: String, CodingKey {
        case id
        case thumbnail
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        thumbnail = try values.decode(Optional<ThumbImage>.self, forKey: .thumbnail)
    }
    
    init(id: Int, thumbnail: ThumbImage) {
        self.id = id
        self.thumbnail = thumbnail
    }
}

extension Comic: Equatable {
    static func ==(lhs: Comic, rhs: Comic) -> Bool {
        let areEqual = lhs.id == rhs.id && lhs.thumbnail == rhs.thumbnail
        return areEqual
    }
}
