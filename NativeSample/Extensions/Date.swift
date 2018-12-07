//
//  Date.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/30/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

// Time Format
public struct TimeFormat {
    static let hh_mm                = "hh:mm"
    static let HH_mm                = "HH:mm"
    static let hh_mm_a              = "hh:mm a"
    static let HH_mm_ss             = "HH:mm:ss"
}

// Date format
public struct DateFormat {
    static let MMDDYYYY            = "MMddYYYY"
    static let YYYY_MM_DD          = "YYYY/MM/dd"
    static let yyyy_MM_dd_T_HH_mm_ss_ssz   = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    static let dd_MMMM_yyyy         = "dd MMMM yyyy" // 25 JUNE 2016
    static let yyyy_MM_dd_HH_mm_ss_z = "yyyy-MM-dd HH:mm:ss +z"
    static let MMM_dd_yyyy_hh_mm    = "MMM dd, yyyy  hh:mm a " // Aug 31, 2015
    static let EEE_MMM_dd_yyyy      = "EEE, MMM dd, yyyy" // Mon, Aug 31, 2015
    static let EEEE_MMMM_dd_yyyy    = "EEEE, MMMM dd, yyyy" // Monday, August 31, 2015
    static let MMM_dd               = "MMM dd" // Mon, Aug 31, 2015
    static let MMM_dd_yyyy          = "MMM dd, yyyy" // Mon, Aug 31, 2015
}

extension Date {
    
    //MARK:  convert date to string
    func string(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func utcDateString(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension String {
    
    //MARK:  convert string to string
    func date(_ format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
    
    func utcDate(_ format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
    
    //MARK:  convert string from one format to others
    func convert(_ fromFormat: String, _ toFormat: String, _ timeZone: TimeZone = TimeZone.current) ->  String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = Locale(identifier:"en_US_POSIX")  // for 12 hours
        let date = dateFormatter.date(from: self as String)
        
        dateFormatter.dateFormat = toFormat as String
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = Locale(identifier:"en_US_POSIX") // for 12 hours
        var dateFormatted : String = String()
        if let date = date {
            dateFormatted = dateFormatter.string(from: date)
        }
        return dateFormatted
    }
}

extension TimeInterval {
    
    private var milliseconds: Int {
        return Int((truncatingRemainder(dividingBy: 1)) * 1000)
    }
    
    private var seconds: Int {
        return Int(self) % 60
    }
    
    private var minutes: Int {
        return (Int(self) / 60 ) % 60
    }
    
    private var hours: Int {
        return Int(self) / 3600
    }
    
    var stringTime: String {
        if hours != 0 {
            return "\(hours)h \(minutes)m \(seconds)s"
        } else if minutes != 0 {
            return "\(minutes)m \(seconds)s"
        } else if milliseconds != 0 {
            return "\(seconds)s \(milliseconds)ms"
        } else {
            return "\(seconds)s"
        }
        
    }
    
    func stringFromTimeInterval() -> String {
        let time = NSInteger(self)
        let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
    }
}


