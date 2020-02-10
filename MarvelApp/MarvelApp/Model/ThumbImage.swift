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
    var imageExtension: String
   
    enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
    
    var fullPath: String {
        return "\(path).\(imageExtension)"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        path = try values.decode(String.self, forKey: .path)
        imageExtension = try values.decode(String.self, forKey: .imageExtension)
    }
    
    init(path: String, imageExtension: String) {
        self.path = path
        self.imageExtension = imageExtension
    }
}

extension ThumbImage: Equatable {
    static func ==(lhs: ThumbImage, rhs: ThumbImage) -> Bool {
        let areEqual = lhs.path == rhs.path && lhs.imageExtension == rhs.imageExtension
        return areEqual
    }
}
