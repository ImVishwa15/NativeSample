//
//  UIApplication.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/28/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

public extension UIApplication {
    
    var topViewController: UIViewController? {
        guard var topViewController = UIApplication.shared.keyWindow?.rootViewController else { return nil }
        while let presentedViewController = topViewController.presentedViewController {
            topViewController = presentedViewController
        }
        return topViewController
    }
    
    var topNavigationController: UINavigationController? {
        return topViewController as? UINavigationController
    }
    
}
