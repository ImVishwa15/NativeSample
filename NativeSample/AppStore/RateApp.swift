//
//  RateApp.swift
//  NativeSample
//
//  Created by Vishwajeet K on 12/3/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit
import StoreKit

public struct RateApp {
    
    static private let maxAttempts: Int = 3
    static private let expireDateKey: String = "SPRateAppExpireDateKey"
    static private let daysIntervalKey: String = "SPRateAppDaysIntervalKey"
    static private let countPresentedNativeDialogKey: String = "SPRateAppCountPresentedNativeDialogKey"
    
    static public func isShowDialog() -> Bool {
        let dateUnwrap = UserDefaults.standard.object(forKey: self.expireDateKey)
        if let date = dateUnwrap as? Date {
            if date < Date.init(timeIntervalSinceNow: 0) {
                return true
            } else {
                print("SPRateApp - Time not expired, not present")
                return false
            }
        } else {
            setBaseTimeInterval()
            print("SPRateApp - Not Set Time Interval. We set dafault value")
            return true
        }
    }
    
    static private func isAvailableNativeDialog() -> Bool {
        let countUnwrap = UserDefaults.standard.object(forKey: self.countPresentedNativeDialogKey)
        if let count = countUnwrap as? Int {
            if count > 0 {
                return true
            } else {
                return false
            }
        } else {
            UserDefaults.standard.set(Int(self.maxAttempts), forKey: self.countPresentedNativeDialogKey)
            return true
        }
    }
    
    static private func didPresentedNativeDialog() {
        let countUnwrap = UserDefaults.standard.object(forKey: self.countPresentedNativeDialogKey)
        if let count = countUnwrap as? Int {
            var newCount = count - 1
            newCount.setIfFewer(when: 0)
            UserDefaults.standard.set(Int(newCount), forKey: self.countPresentedNativeDialogKey)
        } else {
            UserDefaults.standard.set(Int(self.maxAttempts), forKey: self.countPresentedNativeDialogKey)
        }
    }
    
    static public func setBaseTimeInterval() {
        UserDefaults.standard.set(3, forKey: self.daysIntervalKey)
        
        let dateUnwrap = UserDefaults.standard.object(forKey: self.expireDateKey)
        
        if (dateUnwrap as? Date) == nil {
            self.setExpireDate()
        }
    }
    
    static public func setTimeInterval(days: Int) {
        UserDefaults.standard.set(days, forKey: self.daysIntervalKey)
        
        let dateUnwrap = UserDefaults.standard.object(forKey: self.expireDateKey)
        
        if (dateUnwrap as? Date) == nil {
            self.setExpireDate()
        }
    }
    
    static private func setExpireDate() {
        if UserDefaults.standard.value(forKey: daysIntervalKey) == nil {
            self.setBaseTimeInterval()
        }
        
        let countDays = UserDefaults.standard.integer(forKey: daysIntervalKey)
        let timeInterval: TimeInterval = TimeInterval(countDays * 24 * 60 * 60)
        let expireDate = Date.init(timeIntervalSinceNow: timeInterval)
        UserDefaults.standard.set(expireDate, forKey: self.expireDateKey)
    }
    
    static public func openPageInAppStore(id: String) {
        let appID = id
        if let checkURL = URL(string: "http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=\(appID)&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(checkURL, options: [:])
            } else {
                UIApplication.shared.openURL(checkURL)
            }
        } else {
            print("SPRateApp - Invalid AppID")
        }
    }
    
    static public func rateApp(id: String) {
        if RateApp.isAvailableNativeDialog() {
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
                RateApp.didPresentedNativeDialog()
            } else {
                delay(1, closure: {
                    self.openPageInAppStore(id: id)
                })
            }
        } else {
            delay(1, closure: {
                self.openPageInAppStore(id: id)
            })
        }
    }
    
    private init() {}
}


extension Strideable {
    
    public mutating func setIfMore(when value: Self) {
        if self > value {
            self = value
        }
    }
    
    public mutating func setIfFewer(when value: Self) {
        if self < value {
            self = value
        }
    }
}

public func delay(_ delay:Double, closure:@escaping ()->()) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when) {
        closure()
    }
}
