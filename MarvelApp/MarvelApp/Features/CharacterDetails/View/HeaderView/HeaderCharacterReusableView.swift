//
//  HeaderCharacterCollectionReusableView.swift
//  MarvelApp
//
//  Created by Rodrigo Pacheco on 06/02/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import UIKit

class HeaderCharacterReusableView: UICollectionReusableView {
        
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    
    func setup(thumbnailImage: String, description: String) {
        headerImageView.load(thumbnailImage: thumbnailImage)
        descriptionLabel.text = description
        
        if description == withoutDescription {
            
        }
    }
}
