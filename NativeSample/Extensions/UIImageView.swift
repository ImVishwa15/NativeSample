//
//  UIImageView.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/27/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

public extension UIImageView {
    
    //MARK:  circular ImageView
    public func circularImageView(_ color: UIColor = .lightGray) {
        DispatchQueue.main.async {
            self.layer.cornerRadius = self.frame.size.height / 2
            self.layer.borderWidth = 1.0
            self.layer.borderColor = color.cgColor
            self.clipsToBounds = true
        }
    }
    
    //MARK:  set corner radius
    public func cornerRadius(_ borderColor: UIColor = .lightGray, _ radius: CGFloat) {
        DispatchQueue.main.async {
            self.layer.cornerRadius = radius
            self.layer.borderWidth = 1.0
            self.layer.borderColor = borderColor.cgColor
            self.clipsToBounds = true
        }
    }
}

