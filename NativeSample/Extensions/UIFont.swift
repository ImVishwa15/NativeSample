//
//  UIFont.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/29/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

//  FontName
public enum FontName: Int {
    case avenirNext
    case roboto
    
    var name: String {
        switch self {
        case .avenirNext:
            return "AvenirNext"
        case .roboto:
            return "Roboto"
        }
    }
}

//  FontType
public enum FontType: Int {
    case thin
    case light
    case ultraLight
    case regular
    case medium
    case bold
    case semiBold
    case italic
    case none
    
    var type: String {
        switch self {
        case .thin:
            return "-Thin"
        case .light:
            return "-Light"
        case .ultraLight:
            return "-UltraLight"
        case .regular:
            return "-Regular"
        case .medium:
            return "-Medium"
        case .bold:
            return "-Bold"
        case .semiBold:
            return "-SemiBold"
        case .italic:
            return "-Italic"
        default:
            return "-Regular"
            
        }
    }
    
    @available(iOS 8.2, *)
    var fontWeight: UIFont.Weight {
        switch self {
        case .thin:
            return UIFont.Weight.thin
        case .light:
            return UIFont.Weight.light
        case .ultraLight:
            return UIFont.Weight.ultraLight
        case .regular:
            return UIFont.Weight.regular
        case .medium:
            return UIFont.Weight.medium
        case .bold:
            return UIFont.Weight.bold
        case .semiBold:
            return UIFont.Weight.semibold
        default:
            return UIFont.Weight.regular
        }
    }
}

//  FontSize
public enum FontSize: Int {
    case extraSmall
    case small
    case medium
    case large
    case extraLarge
    
    var size: CGFloat {
        switch self {
        case .extraSmall:
            return (UIDevice.UserInterfaceIdiom.pad ? 16.0 : UIDevice.Phone.iPhone5 ? 10 : 12)
        case .small:
            return (UIDevice.UserInterfaceIdiom.pad ? 18.0 : UIDevice.Phone.iPhone5 ? 12 : 14)
        case .medium:
            return (UIDevice.UserInterfaceIdiom.pad ? 20.0 : UIDevice.Phone.iPhone5 ? 14 : 16)
        case .large:
            return (UIDevice.UserInterfaceIdiom.pad ? 22.0 : UIDevice.Phone.iPhone5 ? 18 : 20)
        case .extraLarge:
            return (UIDevice.UserInterfaceIdiom.pad ? 28.0 : UIDevice.Phone.iPhone5 ? 20.0 : 22)
        }
    }
}

extension UIFont {
    
    //MARK:  set system font
    static func system(_ fontType: FontType, _ fontSize: FontSize) -> UIFont {
        if #available(iOS 8.2, *) {
            return UIFont.systemFont(ofSize: fontSize.size, weight: fontType.fontWeight)
        } else {
            return self.createFont(.roboto, fontType, fontSize)
        }
    }
    
    public static func system(_ fontType: FontType, _ size: CGFloat) -> UIFont {
        if #available(iOS 8.2, *) {
            return UIFont.systemFont(ofSize: size, weight: fontType.fontWeight)
        } else {
            return self.createFont(.roboto, fontType, size)
        }
    }
    
    //MARK:  create font
    static func createFont(_ fontName: FontName = .roboto, _ fontType: FontType, _ fontSize: FontSize) -> UIFont {
        return UIFont.init(name: fontName.name + fontType.type, size: fontSize.size)!
    }
    
    static func createFont(_ fontName: FontName = .roboto, _ fontType: FontType, _ size: CGFloat) -> UIFont {
        return UIFont.init(name: fontName.name + fontType.type, size: size)!
    }

}
