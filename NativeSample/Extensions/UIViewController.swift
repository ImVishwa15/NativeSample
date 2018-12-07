//
//  UIViewController.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/27/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

extension UIViewController {
    
    //MARK:  Flip imageView For RTL/LTR
    func loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: [UIView]) {
        if subviews.count > 0 {
            for subView in subviews {
                if (subView is UIImageView) && subView.tag < 0 {
                    let toRightArrow = subView as! UIImageView
                    if let _img = toRightArrow.image {
                        toRightArrow.image = UIImage(cgImage: _img.cgImage!, scale:_img.scale , orientation: UIImage.Orientation.upMirrored)
                    }
                }
                loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: subView.subviews)
            }
        }
    }
    
    public func addChildView(_ child: UIViewController, layoutOption: LayoutOption = .fill) {
        loadViewIfNeeded()
        child.loadViewIfNeeded()
        
        addChild(child)
        view.addSubview(child.view)
        layout(child.view, layoutOption: layoutOption)
        child.didMove(toParent: self)
    }
    
    public func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    private func layout(_ child: UIView, layoutOption: LayoutOption) {
        switch layoutOption {
        case .fill:
            child.fillSuperview()
        case .custom(let customLayout):
            customLayout(view, child)
        }
    }
    
    public enum LayoutOption {
        case fill
        case custom((UIView, UIView) -> Void)
    }

}



