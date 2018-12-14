//
//  WalkThrough.swift
//  NativeSample
//
//  Created by Vishwajeet K on 12/14/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

class WalkThrough {
    
    let title: String
    let image: UIImage

    init(_ title: String, _ image: UIImage) {
        self.title = title
        self.image = image
    }
    
    static func create() -> [WalkThrough] {
        var walkThroughs = [WalkThrough]()
        let walkThrough1 = WalkThrough("Discover new and interesting people nearby", UIImage(named: "intro1")!)
        let walkThrough2 = WalkThrough("Swipe Right to like someone or Swipe Left to pass", UIImage(named: "intro2")!)
        let walkThrough3 = WalkThrough("If they also Swipe Right, It's a match!", UIImage(named: "intro3")!)
        walkThroughs.append(walkThrough1)
        walkThroughs.append(walkThrough2)
        walkThroughs.append(walkThrough3)
        return walkThroughs
    }
}
