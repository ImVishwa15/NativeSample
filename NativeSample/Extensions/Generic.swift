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

