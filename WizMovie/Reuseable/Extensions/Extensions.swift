//
//  Extensions.swift
//  WizMovie
//
//  Created by Admin on 8/27/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import UIKit
import AlamofireImage


extension UIImageView {
    
    func setImage(fromURL url: URL, animatedOnce: Bool = true, withPlaceholder placeholderImage: UIImage? = nil) {
        let hasImage: Bool = (self.image != nil)
        self.af_setImage(
            withURL: url,
            placeholderImage: placeholderImage,
            imageTransition: animatedOnce ? .crossDissolve(0.3) : .noTransition,
            runImageTransitionIfCached: hasImage
        )
    }
}
