//
//  DropDownCell.swift
//  NativeSample
//
//  Created by Vishwajeet K on 12/25/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

class DropDownCell: UITableViewCell {
    
    let label: UILabel = UILabel()
    let textField = IQDropDownTextField()
    
    var fixWidthLabel: CGFloat? = nil
    
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
        self.backgroundColor = UIColor.white
        self.label.textAlignment = .right
        self.label.text = "Label"
        self.label.font = UIFont.system(.regular, 17)
        self.contentView.addSubview(self.label)
        
        self.textField.font = UIFont.system(.regular, 17)
        self.textField.placeholder = "Placeholder"
        self.contentView.addSubview(self.textField)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var labelWidth: CGFloat = self.contentView.frame.width * 0.21
        if let width = self.fixWidthLabel {
            labelWidth = width
        }
        self.label.frame = CGRect.init(x: self.layoutMargins.left, y: 0, width: labelWidth, height: self.contentView.frame.height)
        let space: CGFloat = 15
        self.textField.frame = CGRect.init(x: self.label.frame.bottomXPosition + space, y: 0, width: self.contentView.frame.width - self.label.frame.bottomXPosition - self.layoutMargins.right - space, height: self.contentView.frame.height)
    }
}
