//
//  UIAlertController.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/27/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

typealias ComplitionHandler  = (_ title: String) -> Void

extension UIAlertController {
    
    //MARK:  Show Message & title
    static func show(_ viewController: UIViewController, _ title: String?, _ message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK:  Show Message with Multiple Options
    static func show(_ viewController: UIViewController, _ title: String?, _ message: String?, _ cancelOptions: [String]? = nil, _ otherOptions: [String]? = nil, _ destructiveOptions: [String]? = nil, _ isAlert: Bool = true, _ completion: @escaping ComplitionHandler) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: isAlert ? .alert : .actionSheet)
        if let cancels =  cancelOptions {
            for title in cancels {
                alertController.addAction(UIAlertAction(title: title, style: .cancel, handler: {
                    (action : UIAlertAction) -> Void in
                    completion(action.title!)
                }))
            }
        }
        if let others = otherOptions, others.count > 0 {
            for title in others {
                alertController.addAction(UIAlertAction(title: title, style: .default, handler: {
                    (action : UIAlertAction) -> Void in
                    completion(action.title!)
                }))
            }
        }
        if let distructive = destructiveOptions, distructive.count > 0 {
            for title in distructive {
                alertController.addAction(UIAlertAction(title: title, style: .destructive, handler: {
                    (action : UIAlertAction) -> Void in
                    completion(action.title!)
                }))
            }
        }
        DispatchQueue.main.async {
            if !isAlert && UIDevice.current.userInterfaceIdiom == .pad {
                alertController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
                alertController.popoverPresentationController?.sourceRect = self.sourceRectForBottomAlertController(alertController)()
                alertController.popoverPresentationController!.sourceView = viewController.view;
                viewController.present(alertController, animated: true, completion: nil)
            }
            else {
                viewController.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    //MARK:  Private Method
    private func sourceRectForBottomAlertController() -> CGRect {
        var sourceRect :CGRect = CGRect.zero
        sourceRect.origin.x = self.view.bounds.midX - self.view.frame.origin.x/2.0
        sourceRect.origin.y = self.view.bounds.midY
        return sourceRect
    }
}
