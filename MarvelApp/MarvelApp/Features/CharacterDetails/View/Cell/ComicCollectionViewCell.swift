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
    
    let cornerRadius: CGFloat = 10
    
    func setup(thumbnailImage: String) {
        comicImageView.layer.cornerRadius = cornerRadius
//        comicImageView.clipsToBounds = true
        comicImageView.load(thumbnailImage: thumbnailImage)
    }
}
