//
//  Opener.swift
//  NativeSample
//
//  Created by Vishwajeet K on 12/3/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

struct Opener {
    
    //MARK:  open link url in browser
    public static func redirectToBrowserAndOpenLink(_ link: String) {
        guard let url = URL(string: link) else {
            print("SPOpener - can not create URL")
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    public static func openInsideApp(link: String) {
        
    }
}

