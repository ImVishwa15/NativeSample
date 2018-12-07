//
//  DownloadingButton.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/30/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

class DownloadingButton: UIButton {
    
    //  activity view
    let activityIndicatorView = UIActivityIndicatorView()
    
    //MARK:  setLoadingMode
    func setLoadingMode() {
        self.activityIndicatorView.alpha = 0
        self.activityIndicatorView.isHidden = false
        self.activityIndicatorView.startAnimating()
        self.activityIndicatorView.color = self.titleLabel?.textColor
        self.addSubview(self.activityIndicatorView)
        self.hideContent(completion: {
            Animation.animate(0.2, animations: {
                self.activityIndicatorView.alpha = 1
            })
        })
    }
    
    //MARK:  unsetLoadingMode
    func unsetLoadingMode() {
        Animation.animate(0.2, animations: {
            self.activityIndicatorView.alpha = 0
        }, withComplection: {
            self.activityIndicatorView.removeFromSuperview()
            self.activityIndicatorView.isHidden = true
            self.activityIndicatorView.stopAnimating()
            self.showContent()
        })
    }
    
    //MARK:  layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        self.activityIndicatorView.center = CGPoint.init(x: self.frame.width / 2, y: self.frame.height / 2)
    }
}
