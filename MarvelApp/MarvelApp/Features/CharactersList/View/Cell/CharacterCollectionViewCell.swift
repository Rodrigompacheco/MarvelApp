//
//  CharacterCollectionViewCell.swift
//  MarvelApp
//
//  Created by Rodrigo Pacheco on 06/02/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    func setup(name: String, thumbnailImage: String) {
        characterNameLabel.text = name
        backgroundImageView.load(thumbnailImage: thumbnailImage)
    }
}
