//
//  AppStore.swift
//  NativeSample
//
//  Created by Vishwajeet K on 12/3/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit
import StoreKit

struct AppStore {
    
    static func open(_ appId: String) {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/id\(appId)"),
            UIApplication.shared.canOpenURL(url) {
            print(url)
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    static func icon(_ appId: String, _ complection: @escaping(String?) -> Void) {
        let url = URL(string: "https://itunes.apple.com/by/app/id\(appId)")!
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if data == nil {  complection(nil) }
            else {
                let string = String(data: data!, encoding: .utf8)
                if string == nil { complection(nil) }
                else {
                    let pattern = "<meta itemprop=\"image\" content=\"(.*?)\">"
                    let regex = try? NSRegularExpression(pattern: pattern, options: .dotMatchesLineSeparators)
                    if regex == nil { complection(nil) }
                    else {
                        let matches = regex!.matches(in: string!, options: [], range: NSRange.init(location: 0, length: string!.utf16.count))
                        print(matches)
                        if let match = matches.first {
                            let range = match.range(at: 1)
                            
                            if let swiftRange = range.range(for: string!) {
                                let name = string!.substring(with: swiftRange)
                                complection(name)
                            } else { complection(nil) }
                            
                        } else { complection(nil) }
                    }
                }
            }
            }.resume()
    }
}

extension NSRange {
    func range(for str: String) -> Range<String.Index>? {
        guard location != NSNotFound else { return nil }
        
        guard let fromUTFIndex = str.utf16.index(str.utf16.startIndex, offsetBy: location, limitedBy: str.utf16.endIndex) else { return nil }
        guard let toUTFIndex = str.utf16.index(fromUTFIndex, offsetBy: length, limitedBy: str.utf16.endIndex) else { return nil }
        guard let fromIndex = String.Index(fromUTFIndex, within: str) else { return nil }
        guard let toIndex = String.Index(toUTFIndex, within: str) else { return nil }
        
        return fromIndex ..< toIndex
    }
}
