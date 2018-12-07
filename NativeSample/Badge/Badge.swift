//
//  Badge.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/28/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

public struct Badge {
    
    //MARK:  Reset badge count
    static func reset() {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    //MARK:  Set badge count
    static func set(count: Int) {
        UIApplication.shared.applicationIconBadgeNumber = count
    }
    
    private init() {}
}

