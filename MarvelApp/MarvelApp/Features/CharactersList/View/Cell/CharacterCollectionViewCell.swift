//
//  CharacterCollectionViewCell.swift
//  MarvelApp
//
//  Created by Rodrigo Pacheco on 06/02/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundShadowView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    let cornerRadius: CGFloat = 15
    
    func setup(name: String, thumbnailImage: String) {
        
        characterNameLabel.text = name        
        backgroundImageView.load(thumbnailImage: thumbnailImage)
        
        backgroundImageView.layer.cornerRadius = cornerRadius
        backgroundImageView.clipsToBounds = true
        
        backgroundShadowView.layer.cornerRadius = cornerRadius
    }
}
