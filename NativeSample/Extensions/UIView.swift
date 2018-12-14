//
//  UIView.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/30/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

public extension UIView {
    
    public func fillSuperview() {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = superview.translatesAutoresizingMaskIntoConstraints
        if translatesAutoresizingMaskIntoConstraints {
            autoresizingMask = [.flexibleWidth, .flexibleHeight]
            frame = superview.bounds
        } else {
            topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
            leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
        }
    }
    
    public var viewController: UIViewController? {
        var parent: UIResponder? = self
        while parent != nil {
            parent = parent?.next
            if let viewController = parent as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

// MARK: - layout
public extension UIView {
    
    var bootomXPosition: CGFloat {
        return self.frame.bottomXPosition
    }
    
    var bootomYPosition: CGFloat {
        return self.frame.bottomYPosition
    }
    
    var minSideSize: CGFloat {
        return self.frame.minSideSize
    }
    
    var isWidthLessThanHeight: Bool {
        return self.frame.isWidthLessThanHeight
    }
    
    func rounded() {
        self.layer.cornerRadius = self.minSideSize / 2
    }
    
    func setHeight(_ height: CGFloat) {
        self.frame = CGRect.init(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: height)
    }
    
    func setWidth(_ width: CGFloat) {
        self.frame = CGRect.init(x: self.frame.origin.x, y: self.frame.origin.y, width: width, height: self.frame.height)
    }
    
    func setEqualsFrameFromBounds(_ view: UIView, withWidthFactor widthFactor: CGFloat = 1, maxWidth: CGFloat? = nil, withHeightFactor heightFactor: CGFloat = 1, maxHeight: CGFloat? = nil, withCentering: Bool = false) {
        
        var width = view.bounds.width * widthFactor
        if maxWidth != nil {
            width.setIfMore(when: maxWidth!)
        }
        
        var height = view.bounds.height * heightFactor
        if maxHeight != nil {
            height.setIfMore(when: maxHeight!)
        }
        
        self.frame = CGRect.init(x: 0, y: 0, width: width, height: height)
        
        if withCentering {
            self.center.x = view.frame.width / 2
            self.center.y = view.frame.height / 2
        }
    }
    
    func setEqualsBoundsFromSuperview(customWidth: CGFloat? = nil, customHeight: CGFloat? = nil) {
        
        if self.superview == nil {
            return
        }
        
        self.frame = CGRect.init(origin: CGPoint.zero, size: self.superview!.frame.size)
        
        if customWidth != nil {
            self.frame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: customWidth!, height: self.frame.height))
        }
        
        if customHeight != nil {
            self.frame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: self.frame.width, height: customHeight!))
        }
    }
    
    func resize(to width: CGFloat) {
        let relativeFactor = self.frame.width / self.frame.height
        self.frame = CGRect.init(
            x: self.frame.origin.x,
            y: self.frame.origin.y,
            width: width,
            height: self.frame.height * relativeFactor
        )
    }
    
    func setXCenteringFromSuperview() {
        self.center.x = (self.superview?.frame.width ?? 0) / 2
    }
}

public extension UIView {
    
    func setParalax(amountFactor: CGFloat) {
        let amount = self.minSideSize * amountFactor
        self.setParalax(amount: amount)
    }
    
    func setParalax(amount: CGFloat) {
        self.motionEffects.removeAll()
        let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontal.minimumRelativeValue = -amount
        horizontal.maximumRelativeValue = amount
        
        let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        vertical.minimumRelativeValue = -amount
        vertical.maximumRelativeValue = amount
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontal, vertical]
        self.addMotionEffect(group)
    }
}

// MARK: - convertToImage
public extension UIView {
    
    func convertToImage() -> UIImage {
        return UIImage.drawFromView(self)
    }
}

// MARK: - gradeView
public extension UIView {
    
    func addGrade(alpha: CGFloat, color: UIColor = UIColor.black) -> UIView {
        let gradeView = UIView.init()
        gradeView.alpha = 0
        self.addSubview(gradeView)
        ConstraintsAssistent.setEqualSizeConstraint(gradeView, superVuew: self)
        gradeView.alpha = alpha
        gradeView.backgroundColor = color
        return gradeView
    }
}

// MARK: - shadow
extension UIView {
    
    func setShadow(
        xTranslationFactor: CGFloat,
        yTranslationFactor: CGFloat,
        widthRelativeFactor: CGFloat,
        heightRelativeFactor: CGFloat,
        blurRadiusFactor: CGFloat,
        shadowOpacity: CGFloat,
        cornerRadiusFactor: CGFloat = 0
        ) {
        let shadowWidth = self.frame.width * widthRelativeFactor
        let shadowHeight = self.frame.height * heightRelativeFactor
        
        let xTranslation = (self.frame.width - shadowWidth) / 2 + (self.frame.width * xTranslationFactor)
        let yTranslation = (self.frame.height - shadowHeight) / 2 + (self.frame.height * yTranslationFactor)
        
        let cornerRadius = self.minSideSize * cornerRadiusFactor
        
        let shadowPath = UIBezierPath.init(
            roundedRect: CGRect.init(x: xTranslation, y: yTranslation, width: shadowWidth, height: shadowHeight),
            cornerRadius: cornerRadius
        )
        
        let blurRadius = self.minSideSize * blurRadiusFactor
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = Float(shadowOpacity)
        self.layer.shadowRadius = blurRadius
        self.layer.masksToBounds = false
        self.layer.shadowPath = shadowPath.cgPath;
    }
    
    func setShadow(
        xTranslation: CGFloat,
        yTranslation: CGFloat,
        widthRelativeFactor: CGFloat,
        heightRelativeFactor: CGFloat,
        blurRadius: CGFloat,
        shadowOpacity: CGFloat,
        cornerRadius: CGFloat = 0
        ) {
        let shadowWidth = self.frame.width * widthRelativeFactor
        let shadowHeight = self.frame.height * heightRelativeFactor
        
        let shadowPath = UIBezierPath.init(
            roundedRect: CGRect.init(x: xTranslation, y: yTranslation, width: shadowWidth, height: shadowHeight),
            cornerRadius: cornerRadius
        )
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = Float(shadowOpacity)
        self.layer.shadowRadius = blurRadius
        self.layer.masksToBounds = false
        self.layer.shadowPath = shadowPath.cgPath
    }
    
    func removeShadow() {
        self.layer.shadowColor = nil
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = 0
        self.layer.shadowPath = nil
    }
    
    func addShadowOpacityAnimation(to: CGFloat, duration: CFTimeInterval) {
        let animation = CABasicAnimation(keyPath:"shadowOpacity")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.fromValue = self.layer.cornerRadius
        animation.fromValue = self.layer.shadowOpacity
        animation.toValue = to
        animation.duration = duration
        self.layer.add(animation, forKey: "shadowOpacity")
        self.layer.shadowOpacity = Float(to)
    }
}

// MARK: - animation
extension UIView {
    
    func addCornerRadiusAnimation(to: CGFloat, duration: CFTimeInterval) {
        let animation = CABasicAnimation(keyPath:"cornerRadius")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.fromValue = self.layer.cornerRadius
        animation.toValue = to
        animation.duration = duration
        self.layer.add(animation, forKey: "cornerRadius")
        self.layer.cornerRadius = to
    }
    
    func removeFromSupervVewWithAlphaAnimatable(duration: CGFloat = 0.3) {
        Animation.animate(TimeInterval(duration), animations: {
            self.alpha = 0
        }, withComplection: {
            self.removeFromSuperview()
        })
    }
}


public struct ConstraintsAssistent {
    
    static func setEqualSizeConstraint(_ subView: UIView, superVuew: UIView) {
        subView.translatesAutoresizingMaskIntoConstraints = false;
        let topMarginConstraint = NSLayoutConstraint(
            item: subView,
            attribute: NSLayoutConstraint.Attribute.topMargin,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: superVuew,
            attribute: NSLayoutConstraint.Attribute.top,
            multiplier: 1,
            constant: 0)
        
        let bottomMarginConstraint = NSLayoutConstraint(
            item: subView,
            attribute: NSLayoutConstraint.Attribute.bottomMargin,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: superVuew,
            attribute: NSLayoutConstraint.Attribute.bottom,
            multiplier: 1,
            constant: 0)
        
        let leadingMarginConstraint = NSLayoutConstraint(
            item: subView,
            attribute: NSLayoutConstraint.Attribute.leadingMargin,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: superVuew,
            attribute: NSLayoutConstraint.Attribute.leading,
            multiplier: 1,
            constant: 0)
        
        let trailingMarginConstraint = NSLayoutConstraint(
            item: subView,
            attribute: NSLayoutConstraint.Attribute.trailingMargin,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: superVuew,
            attribute: NSLayoutConstraint.Attribute.trailing,
            multiplier: 1,
            constant: 0)
        
        superVuew.addConstraints([
            topMarginConstraint, bottomMarginConstraint, leadingMarginConstraint, trailingMarginConstraint
            ])
    }
}
