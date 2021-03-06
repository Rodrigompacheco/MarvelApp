//
//  Character.swift
//  MarvelApp
//
//  Created by Rodrigo Pacheco on 05/02/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import Foundation

let withoutDescription = "Without description."

struct Character: Codable {
    let id: Int
    let name: String
    var description: String
    let thumbnail: ThumbImage?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case thumbnail
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        description = try values.decode(String.self, forKey: .description)
        thumbnail = try values.decode(Optional<ThumbImage>.self, forKey: .thumbnail)
    }
    
    init(id: Int, name: String, description: String, thumbnail: ThumbImage) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
    }
}

extension Character: Equatable {
    static func ==(lhs: Character, rhs: Character) -> Bool {
        let areEqual = lhs.id == rhs.id && lhs.name == rhs.name && lhs.description == rhs.description && lhs.thumbnail == rhs.thumbnail
        return areEqual
    }
}


