//
//  Share.swift
//  NativeSample
//
//  Created by Vishwajeet K on 12/3/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

public struct Share {
    
    public struct Native {
        
        static func share(_ text: String? = nil, _ fileNames: [String] = [], _ sourceView: UIView, _ viewController: UIViewController, _ complection: ((_ isSharing: Bool)->())? = nil) {
            
            var shareData: [Any] = []
            if text != nil {
                shareData.append(text!)
            }
            
            for file in fileNames {
                let path = Bundle.main.path(forResource: file, ofType: "")
                if path != nil {
                    let fileData = URL.init(fileURLWithPath: path!)
                    shareData.append(fileData)
                }
            }
            
            let shareViewController = UIActivityViewController(activityItems: shareData, applicationActivities: nil)
            shareViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
                if !completed {
                    complection?(false)
                    return
                }
                complection?(true)
            }
            shareViewController.modalPresentationStyle = .popover
            shareViewController.popoverPresentationController?.sourceView = sourceView
            shareViewController.popoverPresentationController?.sourceRect = sourceView.bounds
            viewController.present(shareViewController, animated: true, completion: nil)
        }
    }
}
