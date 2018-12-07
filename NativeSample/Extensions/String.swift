//
//  String.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/30/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

public struct Regex {
    static let numbersOnly = "^[0-9]+$"
    static let mobileNumber = "^[+]?[0-9]{9,20}$"
    static let email = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
}

extension String {
    
    //MARK:  validate regax
    func validate(_ regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    var isMobileNumber: Bool {
        return validate(Regex.mobileNumber)
    }
    
    var isEmail: Bool {
        return validate(Regex.email)
    }
    
    var isInt: Bool {
        return Int(self) != nil
    }
    
    //MARK:  check string is bool or not
    func isBool() -> Bool? {
        switch self.lowercased() {
        case "true", "yes", "y", "1":
            return true
        case "false", "no", "n","0":
            return false
        default:
            return nil
        }
    }

    public func trimSpace() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

