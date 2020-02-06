//
//  ThumbImage.swift
//  MarvelApp
//
//  Created by Rodrigo Pacheco on 05/02/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import Foundation

struct ThumbImage: Codable {
    var path: String
    var `extension`: String
   
    enum CodingKeys: String, CodingKey {
        case path
        case `extension`
    }
    
    var fullPath: String {
        return "\(path).\(`extension`)"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        path = try values.decode(String.self, forKey: .path)
        `extension` = try values.decode(String.self, forKey: .extension)
    }
}
