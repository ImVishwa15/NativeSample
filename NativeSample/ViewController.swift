//
//  ViewController.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/27/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ComposeDialog.shared.email(self, Composer("Graet", "Good", ["1"])) { (_, _) in
            
        }
    }
}

