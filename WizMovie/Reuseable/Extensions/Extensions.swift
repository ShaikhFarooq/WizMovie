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
    func setImage(fromURL url: URL, animatedOnce: Bool = true, withPlaceholder placeholderImage: UIImage? = #imageLiteral(resourceName: "placeHolder")) {
        let hasImage: Bool = (self.image != nil)
        self.af_setImage(
            withURL: url,
            placeholderImage: placeholderImage,
            imageTransition: animatedOnce ? .crossDissolve(0.3) : .noTransition,
            runImageTransitionIfCached: hasImage
        )
    }
}


extension UILabel {
    func myLabel() {
        textAlignment = .center
        textColor = .white
        backgroundColor = .lightGray
        font = UIFont.systemFont(ofSize: 17)
        numberOfLines = 0
        lineBreakMode = .byCharWrapping
        sizeToFit()
    }
}
