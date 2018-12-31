//
//  HomeViewController.swift
//  NativeSample
//
//  Created by Vishwajeet K on 12/25/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK:  Identifier
    static var identifier: String {
        return "HomeViewController"
    }

    // MARK:  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initialization()
    }
    
    // MARK:  Button Action
    @objc private func logoutButtonAction() {
        UIAlertController.show(self, KAlertTitle, logoutConfirmation, [KCancel], [KYes]) { (title) in
            if title == KYes {
                KAppDelegate.walkThroughViewController()
            }
        }
    }
    
    // MARK:  Initialization
    private func initialization() {
        
        func setUpNavigationBar() {
            self.navigationController?.isNavigationBarHidden = false
            
            if #available(iOS 11.0, *) {
                self.navigationController?.navigationBar.prefersLargeTitles = true
                self.navigationItem.largeTitleDisplayMode = .always
            }
            self.navigationItem.title = homeTitle
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: logoutTitle, style: .done, target: self, action: #selector(logoutButtonAction))
        }
        
        setUpNavigationBar()
    }
}
