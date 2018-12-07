//
//  Spotlight.swift
//  NativeSample
//
//  Created by Vishwajeet K on 12/7/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import Foundation
import CoreSpotlight
import MobileCoreServices

struct Spotlight {
    
    static let domainIdentifier = "by.ivanvorobei.sparrow"
    
    static func addItem(_ identifier: String, _ title: String, _ description: String, _ addedData: Date? = nil, _ keywords: [String] = []) {
        if #available(iOS 9.0, *) {
            let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeMessage as String)
            attributeSet.title = title
            attributeSet.contentDescription = description
            attributeSet.keywords = keywords
            if addedData != nil {
                attributeSet.contentCreationDate = addedData!
            }
            let item = CSSearchableItem(uniqueIdentifier: "\(identifier)", domainIdentifier: Spotlight.domainIdentifier, attributeSet: attributeSet)
            CSSearchableIndex.default().indexSearchableItems([item]) { error in
                if let error = error {
                    print("SPSpotlight addItem error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    static func removeItem(identifier: String) {
        if #available(iOS 9.0, *) {
            CSSearchableIndex.default().deleteSearchableItems(withIdentifiers: ["\(identifier)"]) { error in
                if let error = error {
                    print("SPSpotlight removeItem error: \(error.localizedDescription)")
                }
            }
        }
    }
}
