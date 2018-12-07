//
//  CALayer.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/29/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

extension CALayer {
    
    //MARK:  Rounded the layer corner
    static func rounded(_ allCorners: UIRectCorner, _ radius: CGFloat, _ bounds: CGRect) -> CAShapeLayer {
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: allCorners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        return maskLayer
    }
}
