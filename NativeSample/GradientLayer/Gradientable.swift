//
//  Gradientable.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/29/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import Foundation
import UIKit

protocol GradientableAppliable {
    func apply(_ layer: CAGradientLayer?)
}

public protocol Gradientable {}

public extension Gradientable where Self: UIView {
    
    //MARK:  set gradient options
    public func set(_ options: GradientOptions) {
        if gradientLayer == nil {
            setupGradient()
        }
        options.apply(gradientLayer)
    }
    
    //MARK:  gradient setup
    private func setupGradient() {
        UIView.classInit
        gradientLayer = CAGradientLayer()
        gradientLayer?.frame = bounds
        layer.insertSublayer(gradientLayer!, at: 0)
    }
}

extension UIView {
    
    static var isClassInit: Bool = false
    static let classInit: Void = {
        guard !UIView.isClassInit else {
            return
        }
        UIView.isClassInit = true
        let originalSelector = #selector(layoutSubviews)
        let swizzledSelector = #selector(swizzledlayoutSubviews)
        guard let originalMethod = class_getInstanceMethod(UIView.self, originalSelector),
            let swizzledMethod = class_getInstanceMethod(UIView.self, swizzledSelector) else {
                return
        }
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }()
    
    struct AssociatedKeys {
        static var gradientLayer = "gradientLayer"
    }
    var gradientLayer: CAGradientLayer? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.gradientLayer) as? CAGradientLayer }
        set { objc_setAssociatedObject(self, &AssociatedKeys.gradientLayer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    @objc func swizzledlayoutSubviews() {
        swizzledlayoutSubviews()
        gradientLayer?.frame = bounds
    }
}
