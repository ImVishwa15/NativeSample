//
//  Array.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/30/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

public extension Array {
    
    func contains<T>(_ object: T) -> Bool where T : Equatable {
        return self.filter({$0 as? T == object}).count > 0
    }
    
    func index<T>(_ object: T) -> Int? where T : Equatable {
        return self.index(where: {$0 as? T == object}) ?? nil
    }
}

public extension Array where Element: Equatable {
    @discardableResult
    public mutating func remove(_ element: Element) -> Index? {
        guard let index = index(of: element) else { return nil }
        remove(at: index)
        return index
    }
    
    @discardableResult
    public mutating func remove(elements: [Element]) -> [Index] {
        return elements.compactMap { remove($0) }
    }
}

public extension Array where Element: Hashable {
    public mutating func unify() {
        self = _undefined()
    }
}
