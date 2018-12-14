//
//  CGRect.swift
//  NativeSample
//
//  Created by Vishwajeet K on 12/12/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

extension CGRect {
    
    var bottomXPosition: CGFloat {
        return self.origin.x + self.width
    }
    
    var bottomYPosition: CGFloat {
        return self.origin.y + self.height
    }
    
    var minSideSize: CGFloat {
        return min(self.width, self.height)
    }
    
    var isWidthLessThanHeight: Bool {
        return self.width < self.height
    }
}
