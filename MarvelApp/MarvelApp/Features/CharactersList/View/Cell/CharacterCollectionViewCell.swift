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
    
    func setup(name: String, image: UIImage) {
        characterNameLabel.text = name
        backgroundImageView.image = image
    }
}
