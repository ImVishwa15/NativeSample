//
//  Animation.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/27/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

public class Animation {
    
    /// Animation with duration
    static func animate(_ duration: TimeInterval, animations: (() -> Void)!, delay: TimeInterval = 0, options: UIView.AnimationOptions = [], withComplection completion: (() -> Void)! = {}) {
        
        UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
            animations()
        }, completion: { finished in
            completion()
        })
    }
    
    /// Animation with repitation
    static func animateWithRepeatition(_ duration: TimeInterval, animations: (() -> Void)!, delay: TimeInterval = 0, options: UIView.AnimationOptions = [], withComplection completion: (() -> Void)! = {}) {
        
        var optionsWithRepeatition = options
        optionsWithRepeatition.insert([.autoreverse, .repeat])
        
        self.animate(duration, animations: {
            animations()
        },
                     delay:  delay, options: optionsWithRepeatition, withComplection: {
                        completion()
        })
    }
}
