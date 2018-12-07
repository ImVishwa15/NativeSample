//
//  CustomButton.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/29/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton, Gradientable {
    
    //  button layer corner radius
    @IBInspectable
    var gradientApply: Bool = false {
        didSet {
            applyGradient()
        }
    }
    
    //  button gradient color type
    @IBInspectable
    var gradientType: Int = 0 {
        didSet {
            applyGradient()
        }
    }
    
    //  button font name
    @IBInspectable
    public var fontName: Int = 0 {
        didSet {
            updateFont()
        }
    }
    
    //  button font type
    @IBInspectable
    public var fontType: Int = 0 {
        didSet {
            updateFont()
        }
    }
    
    //  button font size
    @IBInspectable
    public var fontSize: Int = 0 {
        didSet {
            updateFont()
        }
    }
    
    //  button font color
    @IBInspectable
    public var fontColor: Int = 0 {
        didSet {
            if let fontColor = ColorType(rawValue: self.fontColor) {
                self.setTitleColor(fontColor.color, for: .normal)
            }
        }
    }
    
    //  button background color
    @IBInspectable
    public var backColor: Int = 0 {
        didSet {
            if let fontColor = ColorType(rawValue: self.backColor) {
                self.backgroundColor = fontColor.color
            }
        }
    }
    
    //  button layer border width
    @IBInspectable
    var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    //  button layer border color
    @IBInspectable
    var borderColor: Int = 0 {
        didSet {
            if let borderColor = ColorType(rawValue: self.borderColor) {
                self.layer.borderColor = borderColor.color.cgColor
            }
        }
    }
    
    //  button layer corner radius
    @IBInspectable
    var cornerRadius: CGFloat = 0.0 {
        didSet {
            setupUI()
        }
    }
    
    //  set button top left rect corner
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
    
    //  set button top right rect corner
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
    
    //  set button bottom left rect corner
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
    
    //  set button bottom right rect corner
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
    
    //  set label bottom right rect corner
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
    
    //MARK:  apply Gradient
    private func applyGradient() {
        if gradientApply {
            if self.gradientType > 0 {
                if let gradient = GradientColor(rawValue: self.gradientType) {
                    self.set(GradientOptions(gradient.colors, .horizontal))
                }
            }
        }
    }
    
    //MARK:  update Font
    private func updateFont() {
        if let fontName = FontName(rawValue: self.fontName),  let fontType = FontType(rawValue: self.fontType), let fontSize = FontSize(rawValue: self.fontSize) {
            self.titleLabel?.font = UIFont.createFont(fontName, fontType, fontSize)
        }
    }
}
