//
//  ErrorMessage.swift
//  WizMovie
//
//  Created by Admin on 8/29/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import UIKit

class ErrorMessage: UIVisualEffectView {
    
    var text: String? {
        didSet {
            label.text = text
        }
    }
    
    let label: UILabel = UILabel()
    let blurEffect = UIBlurEffect(style: .dark)
    let vibrancyView: UIVisualEffectView
    
    init(text: String) {
        self.text = text
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(effect: blurEffect)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.text = ""
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup() {
        contentView.addSubview(vibrancyView)
        contentView.addSubview(label)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if let superview = self.superview {
            
            let width = superview.frame.size.width - 100
            let height: CGFloat = 80.0
            self.frame = CGRect(x: superview.frame.size.width / 2 - width / 2,
                                y: superview.frame.height / 2 - height / 2,
                                width: width,
                                height: height)
            
            layer.cornerRadius = 8.0
            layer.masksToBounds = true
            label.text = text
            label.numberOfLines = 0
            label.textAlignment = NSTextAlignment.center
            label.frame = CGRect(x: 0,
                                 y: 0,
                                 width: width,
                                 height: height)
            label.textColor = UIColor.white
            label.font = UIFont.boldSystemFont(ofSize: 16)
        }
    }
    
    func show() {
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
    }
}
