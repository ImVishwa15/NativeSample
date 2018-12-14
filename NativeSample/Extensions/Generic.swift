//
//  Generic.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/27/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

public protocol CaseIterable: Hashable {
    static func iterateEnum() -> AnyIterator<Self>
    static var allCases: [Self] { get }
}

public extension CaseIterable {
    
    static public func iterateEnum() -> AnyIterator<Self> {
        var raw = 0
        return AnyIterator {
            let current: Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: self, capacity: 1) { $0.pointee } }
            guard current.hashValue == raw else {
                return nil
            }
            raw += 1
            return current
        }
    }
    static public var allCases: [Self] {
        return Array(Self.iterateEnum())
    }
}

func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
    var i = 0
    return AnyIterator {
        let next = withUnsafePointer(to: &i) {
            $0.withMemoryRebound(to: T.self, capacity: 1) { $0.pointee }
        }
        if next.hashValue != i { return nil }
        i += 1
        return next
    }
}

public func allValues< T: Hashable>(_:T.Type) -> Array<T> {
    var allValues = [T]()
    let iterator = iterateEnum(T.self)
    for item in iterator {
        allValues.append(item)
    }
    
    return allValues
}

protocol OptionalType {
    associatedtype Wrapped
    var optional: Wrapped? { get }
}

extension Optional: OptionalType {
    var optional: Wrapped? { return self }
}

extension Sequence where Iterator.Element: OptionalType {
    func removeNils() -> [Iterator.Element.Wrapped] {
        return self.compactMap { $0.optional }
    }
}

public func < < T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

public func > < T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}

public func == < T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l == r
    default:
        return false
    }
}

public func != < T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l != r
    default:
        return false
    }
}

