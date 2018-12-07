//
//  UIButton.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/27/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

public extension UIButton {
    
    //MARK:  showText
    func showText(_ text: String, withComplection completion: (() -> Void)! = {}) {
        let baseText = self.titleLabel?.text ?? " "
        
        Animation.animate(0.2,
                          animations: {
                            self.titleLabel?.alpha = 0
        }, withComplection: {
            self.setTitle(text, for: .normal)
            
            Animation.animate(0.2, animations: {
                self.titleLabel?.alpha = 1
            }, withComplection: {
                
                Animation.animate(0.2, animations: {
                    self.titleLabel?.alpha = 0
                }, delay: 0.35,
                   withComplection: {
                    self.setTitle(baseText, for: .normal)
                    
                    Animation.animate(0.2, animations: {
                        self.titleLabel?.alpha = 1
                    }, withComplection: {
                        completion()
                    })
                })
            })
        })
    }
    
    //MARK:  setAnimatableText
    func setAnimatableText(_ text: String, withComplection completion: (() -> Void)! = {}) {
        
        Animation.animate(0.2,
                          animations: {
                            self.titleLabel?.alpha = 0
        }, withComplection: {
            self.setTitle(text, for: .normal)
            
            Animation.animate(0.2, animations: {
                self.titleLabel?.alpha = 1
            }, withComplection: {
                completion()
                
            })
        })
    }
    
    //MARK:  hideContent
    func hideContent(completion: (() -> Void)! = {}) {
        Animation.animate(0.2,
                          animations: {
                            self.titleLabel?.alpha = 0
        }, withComplection: {
            completion()
        })
    }
    
    //MARK:  showContent
    func showContent(completion: (() -> Void)! = {}) {
        Animation.animate(0.2,
                          animations: {
                            self.titleLabel?.alpha = 1
        }, withComplection: {
            completion()
        })
    }
    
    //MARK:  setTitleColor
    func setTitleColorForNoramlAndHightlightedStates(color: UIColor) {
        self.setTitleColor(color, for: .normal)
        self.setTitleColor(color.withAlphaComponent(0.7), for: .highlighted)
    }
        
    //MARK:  centerTextAndImage
    func centerTextAndImage(_ spacing: CGFloat) {
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }

}
