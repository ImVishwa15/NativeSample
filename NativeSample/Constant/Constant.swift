//
//  Constant.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/29/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

public struct CustomColor {
    static let red = UIColor("FF3B30")
    static let orange = UIColor("FF9500")
    static let yellow = UIColor("FFCC00")
    static let green = UIColor("4CD964")
    static let tealBlue = UIColor("5AC8FA")
    static let blue = UIColor("007AFF")
    static let purple = UIColor("5856D6")
    static let pink = UIColor("FF2D55")
    static let white = UIColor("FFFFFF")
    static let customGray = UIColor("EFEFF4")
    static let lightGray = UIColor("E5E5EA")
    static let lightGray2 = UIColor("D1D1D6")
    static let midGray = UIColor("C7C7CC")
    static let gray = UIColor("8E8E93")
    static let black = UIColor("000000")
}


//  ColorType
public enum ColorType: Int {
    case white
    case black
    case lightGray
    case blue
    case red
    
    var color: UIColor {
        switch self {
        case .white:
            return .white
        case .black:
            return .black
        case .lightGray:
            return .gray
        case .blue:
            return .blue
        case .red:
            return .red
        }
    }
}

//  GradientColor
public enum GradientColor: Int {
    case white
    case blue
    case green
    case orange
    
    var colors: [UIColor] {
        switch self {
        case .white:
            return [UIColor.white]
        case .blue:
            return [CustomColor.blue, CustomColor.purple]
        case .green:
            return [CustomColor.green, CustomColor.gray]
        case .orange:
            return [CustomColor.orange, CustomColor.yellow]
        }
    }
}
