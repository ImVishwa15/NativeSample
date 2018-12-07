//
//  UILabel.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/28/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

extension UILabel {
    
    //MARK:  set shadow offset
    func setShadowOffsetForLetters(_ blurRadius: CGFloat = 0, _ widthOffset: CGFloat = 0, _ heightOffset: CGFloat, _ opacity: CGFloat) {
        self.layer.shadowRadius = blurRadius
        self.layer.shadowOffset = CGSize(
            width: widthOffset,
            height: heightOffset
        )
        self.layer.shadowOpacity = Float(opacity)
    }
    
    func setShadowOffsetFactorForLetters(_ blurRadius: CGFloat = 0, _ widthOffsetFactor: CGFloat = 0, _ heightOffsetFactor: CGFloat, _ opacity: CGFloat) {
        let widthOffset = widthOffsetFactor * self.frame.width
        let heightOffset = heightOffsetFactor * self.frame.height
        self.setShadowOffsetForLetters(blurRadius, widthOffset, heightOffset, opacity)
    }
    
    //MARK:  remove shadow
    func removeShadowForLetters() {
        self.setShadowOffsetForLetters(0, 0, 0, 0)
    }
    
    //MARK:  set center alignment
    func setCenteringAlignment() {
        self.textAlignment = .center
        self.baselineAdjustment = .alignCenters
    }
}
