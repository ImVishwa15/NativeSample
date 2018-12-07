//
//  UIDevice.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/27/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit
import CoreTelephony

public extension UIDevice {
    
    //MARK:  check the device orientation
    struct Orientation {
        static var isLanscape = UIDevice.current.orientation.isLandscape
        static var isPortrait = UIDevice.current.orientation.isPortrait
        static var isFlat = UIDevice.current.orientation.isFlat
        struct Landscape {
            static let left = UIDevice.current.orientation == .landscapeLeft
            static let right = UIDevice.current.orientation == .landscapeRight
        }
        struct Portrait {
            static var up = UIDevice.current.orientation == .portrait
            static var down = UIDevice.current.orientation == .portraitUpsideDown
        }
        struct Flat {
            static var faceUp = UIDevice.current.orientation == .faceUp
            static var faceDown = UIDevice.current.orientation == .faceDown
        }
    }
    
    //MARK:  check the battery states
    struct BatteryState {
        static var unplugged = UIDevice.current.batteryState == .unplugged
        static var charging = UIDevice.current.batteryState == .charging
        static var full = UIDevice.current.batteryState == .full
        static var unknown = UIDevice.current.batteryState == .unknown
    }
    
    //MARK:  check the device type
    struct UserInterfaceIdiom {
        static let simulator: Bool = {
            var isSim = false
            #if arch(i386) || arch(x86_64)
            isSim = true
            #endif
            return isSim
        }()
        static let phone = UIDevice.current.userInterfaceIdiom == .phone
        static let pad = UIDevice.current.userInterfaceIdiom == .pad
        static let tv = UIDevice.current.userInterfaceIdiom == .tv
        static let carPlay = UIDevice.current.userInterfaceIdiom == .carPlay
    }
    
    //MARK:  check the device screen size
    struct ScreenSize {
        static let width = UIScreen.main.bounds.size.width
        static let height = UIScreen.main.bounds.size.height
        static let maximumLength = max(width, height)
        static let minimumLength = min(width, height)
    }
    
    //MARK:  check the iPhone types
    struct Phone {
        static let iPhone4 = UserInterfaceIdiom.phone && ScreenSize.maximumLength == 480.0
        static let iPhone5 = UserInterfaceIdiom.phone && ScreenSize.maximumLength == 568.0
        static let iPhone6 = UserInterfaceIdiom.phone && ScreenSize.maximumLength == 667.0
        static let iPhone7 = iPhone6
        static let iPhone8 = iPhone6
        static let iPhone6Plus = UserInterfaceIdiom.phone && ScreenSize.maximumLength == 736.0
        static let iPhone7Plus = iPhone6Plus
        static let iPhone8Plus = iPhone6Plus
        static let iPhoneX = UserInterfaceIdiom.phone && ScreenSize.maximumLength == 812.0
        static let iPhoneXS = iPhoneX
        static let iPhoneXSMax = UserInterfaceIdiom.phone && ScreenSize.maximumLength == 2688
        static let iPhoneXR = UserInterfaceIdiom.phone && ScreenSize.maximumLength == 1792.0
    }
    
    //MARK:  check the iPad types
    struct Pad {
        static let iPad = UserInterfaceIdiom.pad && ScreenSize.maximumLength == 1024.0
        static let iPadPro = UserInterfaceIdiom.pad && ScreenSize.maximumLength == 1366.0
    }
    
    //MARK:  check the iOS version types
    struct iOSVersion {
        private static let iOSVersion = (UIDevice.current.systemVersion as NSString).floatValue
        static let iOS7 = (iOSVersion >= 7.0 && iOSVersion < 8.0)
        static let iOS8 = (iOSVersion >= 8.0 && iOSVersion < 9.0)
        static let iOS9 = (iOSVersion >= 9.0 && iOSVersion < 10.0)
        static let iOS10 = (iOSVersion >= 10.0 && iOSVersion < 11.0)
        static let iOS11 = (iOSVersion >= 11.0 && iOSVersion < 12.0)
        static let iOS12 = (iOSVersion >= 12.0 && iOSVersion < 13.0)
    }
    
    //MARK:  check the device details types
    struct Detail {
        static let name                =   UIDevice.current.name
        static let model               =   UIDevice.current.model
        static let localizedModel      =   UIDevice.current.localizedModel
        static let systemName          =   UIDevice.current.systemName
        static let systemVersion       =   UIDevice.current.systemVersion
        static let batteryLavel        =   UIDevice.current.batteryLevel
        static let uuid                =   UIDevice.current.identifierForVendor?.uuidString
        static let language            =   NSLocale.preferredLanguages
        static let languageCode        =   NSLocale.isoLanguageCodes
        static let countryCode         =   NSLocale.isoCountryCodes
        static let currencyCode        =   NSLocale.isoCurrencyCodes
        static let iOSVersion          =   UIDevice.current.systemVersion
        static let carrierName: String? =   UIDevice.carrier()
        static let is12HourFormat: Bool    =   UIDevice.timeFormat()
        static var modelName: String {
            var systemInfo = utsname()
            uname(&systemInfo)
            let machineMirror = Mirror(reflecting: systemInfo.machine)
            let identifier = machineMirror.children.reduce("") { identifier, element in
                guard let value = element.value as? Int8, value != 0 else { return identifier }
                return identifier + String(UnicodeScalar(UInt8(value)))
            }
            
            switch identifier {
            case "iPod5,1":                                 return "iPod Touch 5"
            case "iPod7,1":                                 return "iPod Touch 6"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad6,11", "iPad6,12":                    return "iPad 5"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator"
            default:                                        return identifier
            }
        }
    }
    
    //MARK:  Return device carrier name
    private class func carrier() -> String? {
        let phoneInfo = CTTelephonyNetworkInfo()
        if let services = phoneInfo.serviceSubscriberCellularProviders {
            for (_, value) in services {
                if value.carrierName?.count == 0 {
                    return "Wifi"
                }
                return value.carrierName
            }
        }
        return "Wifi"
    }
    
    private class func timeFormat() -> Bool {
        let locale = NSLocale.current
        let formatter : NSString = DateFormatter.dateFormat(fromTemplate: "j", options:0, locale:locale)! as NSString
        if formatter.contains("a") {
            return true  //phone is set to 12 hours
        } else {
            return false //phone is set to 24 hours
        }
    }
}

//MARK:  Get details about build & version
public struct AppDetails {
    static let version = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    static let build   = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
}

