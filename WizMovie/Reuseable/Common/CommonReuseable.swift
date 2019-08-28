//
//  CommonReuseable.swift
//  WizMovie
//
//  Created by Admin on 8/29/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import Foundation

func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}
