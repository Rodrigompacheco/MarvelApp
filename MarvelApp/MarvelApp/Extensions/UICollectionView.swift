//
//  UICollectionView.swift
//  MarvelApp
//
//  Created by Rodrigo Pacheco on 07/02/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import UIKit

extension UICollectionView {
    var sizeForCards: CGSize {
        let padding: CGFloat =  30
        let collectionViewSize = self.frame.size.width - padding
        let percentageOfWidth: CGFloat = 0.50
        let percentageOfHeight: CGFloat = 0.35
        
        return CGSize(width: collectionViewSize * percentageOfWidth,
                      height: self.frame.height * percentageOfHeight)
    }
}
