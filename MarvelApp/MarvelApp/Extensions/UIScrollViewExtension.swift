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
        return self.contentOffset.y == (self.contentSize.height - self.frame.size.height) ? true : false
    }
}
