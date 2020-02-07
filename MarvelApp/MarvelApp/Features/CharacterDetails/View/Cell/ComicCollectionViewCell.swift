//
//  ComicCollectionViewCell.swift
//  MarvelApp
//
//  Created by Rodrigo Pacheco on 06/02/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import UIKit

class ComicCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var comicImageView: UIImageView!
    
    func setup(thumbnailImage: String) {
        comicImageView.load(thumbnailImage: thumbnailImage)
    }
}
