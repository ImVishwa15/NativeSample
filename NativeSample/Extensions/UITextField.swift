//
//  UITextField.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/27/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

extension UITextField {
    
    //MARK:  isEmpty
    var isEmpty: Bool {
        get {
            if self.text == "" || self.text == nil {
                return true
            }
            return false
        }
    }
}

