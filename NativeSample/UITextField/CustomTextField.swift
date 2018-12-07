//
//  CustomTextField.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/30/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit
import Foundation

@IBDesignable
class CustomTextField: UITextField {
    
    //  text field font name
    @IBInspectable
    public var fontName: Int = 0 {
        didSet {
            updateFont()
        }
    }
    
    //  text field font type
    @IBInspectable
    public var fontType: Int = 0 {
        didSet {
            updateFont()
        }
    }
    
    //  text field font size
    @IBInspectable
    public var fontSize: Int = 0 {
        didSet {
            updateFont()
        }
    }
    
    //  text field font color
    @IBInspectable
    public var fontColor: Int = 0 {
        didSet {
            if let fontColor = ColorType(rawValue: self.fontColor) {
                self.textColor = fontColor.color
            }
        }
    }
    
    //  text field place holder color
    @IBInspectable
    var placeHolderColor: Int = 0 {
        didSet {
            if let fontColor = ColorType(rawValue: self.fontColor) {
                self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: fontColor.color])
            }
        }
    }
    
    //  text field background color
    @IBInspectable
    public var backColor: Int = 0 {
        didSet {
            if let fontColor = ColorType(rawValue: self.backColor) {
                self.backgroundColor = fontColor.color
            }
        }
    }
    
    //  text field layer border width
    @IBInspectable
    var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    //  text field layer border color
    @IBInspectable
    var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    //  text field layer corner radius
    @IBInspectable
    var cornerRadius: CGFloat = 0.0 {
        didSet {
            setupUI()
        }
    }
    
    //  set text field top left rect corner
    @IBInspectable
    var topLeft: Bool = false {
        didSet {
            if topLeft {
                allCorners.update(with: .topLeft)
                conernerMask.update(with: .layerMinXMinYCorner)
            }
            setupUI()
        }
    }
    
    //  set text field top right rect corner
    @IBInspectable
    var topRight: Bool = false {
        didSet {
            if topRight {
                allCorners.update(with: .topRight)
                conernerMask.update(with: .layerMaxXMinYCorner)
            }
            setupUI()
        }
    }
    
    //  set text field bottom left rect corner
    @IBInspectable
    var bottomLeft: Bool = false {
        didSet {
            if bottomLeft {
                allCorners.update(with: .bottomLeft)
                conernerMask.update(with: .layerMinXMaxYCorner)
            }
            setupUI()
        }
    }
    
    //  set text field bottom right rect corner
    @IBInspectable
    var bottomRight: Bool = false {
        didSet {
            if bottomRight {
                allCorners.update(with: .bottomRight)
                conernerMask.update(with: .layerMaxXMaxYCorner)
            }
            setupUI()
        }
    }
    
    //  bottomInset
    @IBInspectable
    var bottomInset: CGFloat = 0.0 {
        didSet {
            padding.bottom = bottomInset
        }
    }
    
    //  leftInset
    @IBInspectable
    var leftInset: CGFloat = 0.0 {
        didSet {
            padding.left = leftInset
        }
    }
    
    //  rightInset
    @IBInspectable
    var rightInset: CGFloat = 0.0 {
        didSet {
            padding.right = rightInset
        }
    }
    
    //  topInset
    @IBInspectable
    var topInset: CGFloat = 0.0 {
        didSet {
            padding.top = topInset
        }
    }
    
    //  set text field bottom right rect corner
    @IBInspectable
    var rotation: Int = 0 {
        didSet {
            let radians = CGFloat(CGFloat(Double.pi) * CGFloat(rotation) / CGFloat(180.0))
            self.transform = CGAffineTransform(rotationAngle: radians)
        }
    }
    
    //  all rect corner
    private var allCorners: UIRectCorner = []
    private var conernerMask: CACornerMask = []
    private lazy var padding: UIEdgeInsets = {
        let padding = UIEdgeInsets.zero
        return padding
    }()
    
    //MARK:  View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    //MARK:  SetupUI
    private func setupUI() {
        self.clipsToBounds = true
        if #available(iOS 11.0, *) {
            self.layer.cornerRadius = self.cornerRadius
            self.layer.maskedCorners = self.conernerMask
        }
        else {
            self.layer.mask = CALayer.rounded(allCorners, self.cornerRadius, self.bounds)
        }
        self.setNeedsDisplay()
    }
    
    //MARK:  update Font
    private func updateFont() {
        if let fontName = FontName(rawValue: self.fontName),  let fontType = FontType(rawValue: self.fontType), let fontSize = FontSize(rawValue: self.fontSize) {
            self.font = UIFont.createFont(fontName, fontType, fontSize)
        }
    }
    
    //MARK:  update inset edge
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
