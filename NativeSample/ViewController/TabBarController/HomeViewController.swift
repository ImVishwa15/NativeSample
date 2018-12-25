//
//  HomeViewController.swift
//  NativeSample
//
//  Created by Vishwajeet K on 12/25/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButtonAction(_ sender: UIButton) {
        KAppDelegate.walkThroughViewController()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
