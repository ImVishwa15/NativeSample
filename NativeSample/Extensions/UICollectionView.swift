//
//  UICollectionView.swift
//  NativeSample
//
//  Created by Vishwajeet K on 12/12/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

extension UICollectionViewCell: ReusableView {}

extension UICollectionView {
    
    func registerCell<T: UICollectionViewCell>(ofType type: T.Type) {
        let cellName = String(describing: T.self)
        if Bundle.main.path(forResource: cellName, ofType: "nib") != nil {
            register(UINib(nibName: cellName, bundle: Bundle.main), forCellWithReuseIdentifier: cellName)
        } else {
            register(T.self, forCellWithReuseIdentifier: cellName)
        }
    }

    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }
        return cell
    }
}
