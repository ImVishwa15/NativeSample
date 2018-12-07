//
//  Int.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/30/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

public extension Int {
    
    static func random(_ n: Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    }
    
    static func random(min: Int, max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max - min - 1))) + min
    }
    
    static var uniqueID: Int {
        let date = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "MMddyyHHmmss.SSS"
        let dateUUID = String(formatter.string(from: date).split(separator: ".").joined())
        return Int("\(dateUUID)\(Int.random(3))")!
    }
}

