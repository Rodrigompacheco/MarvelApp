//
//  UIImageView.swift
//  MarvelApp
//
//  Created by Rodrigo Pacheco on 06/02/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func load(thumbnailImage: String) {
        let url = URL(string: thumbnailImage)
        kf.indicatorType = .activity
        lock()
        kf.setImage(with: url, completionHandler: { [weak self] (_, _, _, _) in
            guard let self = self else { return }
            self.unlock()
        })
    }
}
