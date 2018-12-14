//
//  UITableView.swift
//  NativeSample
//
//  Created by Vishwajeet K on 12/12/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {
    
    public func highlighted() {
        self.setHighlighted(true, animated: false)
        self.setHighlighted(false, animated: true)
    }
}

extension UITableView {
    
    func registerCell<T: UITableViewCell>(ofType type: T.Type) {
        let cellName = String(describing: T.self)
        if Bundle.main.path(forResource: cellName, ofType: "nib") != nil {
            register(UINib(nibName: cellName, bundle: Bundle.main), forCellReuseIdentifier: cellName)
        } else {
            register(T.self, forCellReuseIdentifier: cellName)
        }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }
        
        return cell
    }
}

