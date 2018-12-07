//
//  GradientOptions.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/29/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import Foundation
import UIKit

//  The direction to draw the gradient, in a single point coordinate space.
public enum Direction {
    case vertical
    case horizontal
    case topRightToBottomLeft
    case topLeftToBottomRight
    case custom(CGPoint, CGPoint)
    
    //  The start point of the gradient when drawn.
    var startPoint: CGPoint {
        switch self {
        case .vertical:
            return CGPoint(x: 0.5, y: 0.0)
        case .horizontal:
            return CGPoint(x: 0, y: 0.5)
        case .topRightToBottomLeft:
            return CGPoint(x: 0.0, y: 1.0)
        case .topLeftToBottomRight:
            return CGPoint(x: 0.0, y: 0.0)
        case .custom(let start, _):
            return start
        }
    }
    
    //  The end point of the gradient when drawn.
    var endPoint: CGPoint {
        switch self {
        case .vertical:
            return CGPoint(x: 0.5, y: 1.0)
        case .horizontal:
            return CGPoint(x: 1.0, y: 0.5)
        case .topRightToBottomLeft:
            return CGPoint(x: 1.0, y: 0.0)
        case .topLeftToBottomRight:
            return CGPoint(x: 1.0, y: 1.0)
        case .custom(_, let end):
            return end
        }
    }
}

public struct GradientOptions: GradientableAppliable {
    
    var colors: [UIColor]?
    var locations: [NSNumber]?
    var direction: Direction?
    
    public init(_ colors: [UIColor]? = nil, _ direction: Direction? = nil, _ locations: [NSNumber]? = nil) {
        self.colors = colors
        self.locations = locations
        self.direction = direction
    }
    
    //MARK:  apply gradient
    func apply(_ layer: CAGradientLayer?) {
        layer?.colors = colors?.compactMap { $0.cgColor } ?? layer?.colors
        layer?.locations = locations ?? layer?.locations
        applyDirection(layer)
    }
    
    // MARK:  apply direction
    private func applyDirection(_ layer: CAGradientLayer?) {
        guard let direction = direction else {
            return
        }
        layer?.startPoint = direction.startPoint
        layer?.endPoint   = direction.endPoint
    }
}
