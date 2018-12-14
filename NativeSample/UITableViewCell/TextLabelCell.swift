//
//  TextLabelCell.swift
//  NativeSample
//
//  Created by Vishwajeet K on 12/12/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

@available(iOS 9.0, *)
class TextLabelCell: UITableViewCell {
    
    let label = UILabel()
    
    //MARK:  Identifier
    static var identifier: String {
        return String(describing: self)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = UIColor.clear
        self.label.text = "Label"
        self.label.numberOfLines = 0
        self.label.font = UIFont.system(.regular, 13)
        self.label.textColor = CustomColor.darkGray
        self.contentView.addSubview(self.label)
        
        let marginGuide = contentView.layoutMarginsGuide
        
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        self.label.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 2).isActive = true
        self.label.bottomAnchor.constraint(lessThanOrEqualTo: marginGuide.bottomAnchor, constant: 0).isActive = true
        self.label.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
    }
}
