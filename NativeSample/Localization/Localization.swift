//
//  SwizzleClass.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/28/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

public struct LanguageType {
    static let english =  "English"
    static let chineseTraditional = "繁体中文"
    static let chineseSimplified = "简体中文"
}

let APPLE_LANGUAGE_KEY = "AppleLanguages"

class Localization {
    
    // Swizzling methods
    static func initialization() {
        methodSwizzleGivenClassName(cls: UITextField.self, originalSelector: #selector(UITextField.layoutSubviews), overrideSelector: #selector(UITextField.customlayoutSubviews))
        methodSwizzleGivenClassName(cls: UILabel.self, originalSelector: #selector(UILabel.layoutSubviews), overrideSelector: #selector(UILabel.customlayoutSubviews))
        methodSwizzleGivenClassName(cls: UITextView.self, originalSelector: #selector(UITextView.layoutSubviews), overrideSelector: #selector(UITextView.customlayoutSubviews))
        methodSwizzleGivenClassName(cls: UIButton.self, originalSelector: #selector(UIButton.layoutSubviews), overrideSelector: #selector(UIButton.customlayoutSubviews))
        methodSwizzleGivenClassName(cls: UIApplication.self, originalSelector: #selector(getter: UIApplication.userInterfaceLayoutDirection), overrideSelector: #selector(getter: UIApplication.customUserInterfaceLayoutDirection))

    }
}

extension UITextField {
    //MARK:  Override layoutSubviews method
    @objc func customlayoutSubviews() {
        self.customlayoutSubviews()
        if self.isKind(of: NSClassFromString("UITextFieldLabel")!) {
            return // handle special case with uitextfields
        }
        self.tintColor = self.textColor
        if UIApplication.isRTL()  {
            if self.textAlignment == .center { return }
            self.textAlignment = .right
        } else {
            if self.textAlignment == .center { return }
            self.textAlignment = .left
        }
    }
}

extension UILabel {
    //MARK:  Override layoutSubviews method
    @objc func customlayoutSubviews() {
        self.customlayoutSubviews()
        if UIApplication.isRTL()  {
            if self.textAlignment == .center { return }
            self.textAlignment = .right
        } else {
            if self.textAlignment == .center { return }
            self.textAlignment = .left
        }
    }
}

extension UITextView {
    //MARK:  Override layoutSubviews method
    @objc func customlayoutSubviews() {
        self.customlayoutSubviews()
        self.tintColor = self.textColor
        if UIApplication.isRTL()  {
            if self.textAlignment == .center { return }
            self.textAlignment = .right
        } else {
            if self.textAlignment == .center { return }
            self.textAlignment = .left
        }
    }
}

extension UIButton {
    //MARK:  Override layoutSubviews method
    @objc func customlayoutSubviews() {
        self.customlayoutSubviews()
        if UIApplication.isRTL()  {
            if self.titleLabel?.textAlignment == .center { return }
            self.titleLabel?.textAlignment = .right
        } else {
            if self.titleLabel?.textAlignment == .center { return }
            self.titleLabel?.textAlignment = .left
        }
    }
}

extension UIApplication {
    class func isRTL() -> Bool {
        return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
    }
    
   @objc var customUserInterfaceLayoutDirection : UIUserInterfaceLayoutDirection {
        get {
            var direction = UIUserInterfaceLayoutDirection.leftToRight
            if Language.isRightToLeft() {
                direction = .rightToLeft
            }
            return direction
        }
    }

}

class Language {
    
    //MARK:  Set the configuration for RTL
    static func isRightToLeft() -> Bool {
        return Language.currentAppleLanguage() == "ar"
    }
    
    /// get current Apple language
    class func currentAppleLanguage() -> String {
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        let endIndex = current.startIndex
        let reqIndex = current.index(endIndex, offsetBy: 2)
        let finalStr = String(current[..<reqIndex])
        return finalStr
    }
    
    class func currentAppleLanguageFull() -> String{
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        return current
    }
    
    /// set @lang to be the first in Applelanguages list
    class func setAppleLanguage(_ lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang,currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }
    
    // language
    static func getLanguage() -> String {
        if let language = UserDefaults.standard.string(forKey: APPLE_LANGUAGE_KEY), language.count > 0 {
            return language
        }
        let languages = Locale.preferredLanguages
        if languages.count > 0 {
            let arr = languages.first?.components(separatedBy: "-")
            let deviceLanguage = arr?.first //en
            if deviceLanguage == "zh-Hant" {
                return LanguageType.chineseTraditional
            }
            if deviceLanguage == "zh-Hans" {
                return LanguageType.chineseTraditional
            }
            return LanguageType.english
        }
        return LanguageType.english
    }
    
    /// set @lang to be the first in Applelanguages list
    static func setLanguage(_ stringValue: String?) {
        if let selectedlanguage = stringValue {
            UserDefaults.standard.set(selectedlanguage, forKey: APPLE_LANGUAGE_KEY)
        }
        else {
            UserDefaults.standard.removeObject(forKey: APPLE_LANGUAGE_KEY)
        }
        UserDefaults.standard.synchronize()
    }
    
    static func switchLanguage() {
        var transition: UIView.AnimationOptions = .transitionFlipFromLeft
        if Language.isRightToLeft() {
            Language.setAppleLanguage("ar")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            Language.setAppleLanguage("en")
            transition = .transitionFlipFromRight
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        rootviewcontroller.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "rootnav")
        let mainwindow = (UIApplication.shared.delegate?.window!)!
        mainwindow.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
        UIView.transition(with: mainwindow, duration: 0.55001, options: transition, animations: { () -> Void in
        }) { (finished) -> Void in
            
        }
    }
}

extension String {
    //MARK:  functions for localization
    var languageCode: String {
        switch self {
        case LanguageType.english:
            return "en"
        case LanguageType.chineseTraditional:
            return "zh-Hant"
        case LanguageType.chineseSimplified:
            return "zh-Hans"
        default:
            return "en"
        }
    }
    
    func localized() -> String {
        // save language code
        if let path = Bundle.main.path(forResource: Language.getLanguage().languageCode, ofType: "lproj") {
            let bundle = Bundle(path: path)
            return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
        }
        else if let path = Bundle.main.path(forResource: "Base", ofType: "lproj") {
            let bundle = Bundle(path: path)
            return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
        }
        return self
    }
}

extension Bundle {
    func specialLocalizedStringForKey(_ key: String, value: String?, table tableName: String?) -> String {
        if self == Bundle.main {
            let currentLanguage = Language.currentAppleLanguage()
            var bundle = Bundle();
            if let _path = Bundle.main.path(forResource: Language.currentAppleLanguageFull(), ofType: "lproj") {
                bundle = Bundle(path: _path)!
            }else
                if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
                    bundle = Bundle(path: _path)!
                } else {
                    let _path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
                    bundle = Bundle(path: _path)!
            }
            return (bundle.specialLocalizedStringForKey(key, value: value, table: tableName))
        } else {
            return (self.specialLocalizedStringForKey(key, value: value, table: tableName))
        }
    }
}


/// Exchange the implementation of two methods of the same Class
func methodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    let origMethod: Method = class_getInstanceMethod(cls, originalSelector)!
    let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector)!
    if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod))
    } else {
        method_exchangeImplementations(origMethod, overrideMethod)
    }
}
