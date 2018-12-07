//
//  Double.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/30/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

public extension Double {
    
    static func random() -> Double {
        return Double(arc4random()) / 0xFFFFFFFF
    }
    
    static func random(min: Double, max: Double) -> Double {
        return Double.random() * (max - min) + min
    }
}

