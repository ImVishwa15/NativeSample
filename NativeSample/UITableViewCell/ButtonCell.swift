//
//  ButtonCell.swift
//  NativeSample
//
//  Created by Vishwajeet K on 12/12/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

class ButtonCell: UITableViewCell {
    
    let button = DownloadingButton()
    
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
        self.button.setTitle("Button", for: .normal)
        self.button.setTitleColorForNoramlAndHightlightedStates(color: CustomColor.blue)
        self.button.titleLabel?.font = UIFont.system(.medium, 17)
        self.contentView.addSubview(self.button)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.button.setEqualsBoundsFromSuperview()
    }
}
