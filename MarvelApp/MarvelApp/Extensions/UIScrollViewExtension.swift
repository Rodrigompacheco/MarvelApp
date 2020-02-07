//
//  UIScrollViewExtension.swift
//  MarvelApp
//
//  Created by Rodrigo Pacheco on 06/02/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import UIKit

extension UIScrollView {
    var reachedBottom: Bool {
        let visibleHeight = frame.height - contentInset.top - contentInset.bottom
        let yPoint = contentOffset.y + contentInset.top
        let threshold = max(0.0, contentSize.height - visibleHeight)
        return yPoint > threshold
    }
}
