//
//  RightLargeTableCell.swift
//  UICatalog
//
//  Created by ichikawa on 2020/10/14.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

class RightLargeTableCell: UITableViewCell {

    @IBOutlet private weak var rightLargeImageWidth: NSLayoutConstraint!
    @IBOutlet private weak var leftStackViewWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let frameWidth = UIScreen.main.bounds.width - (8 * 2)
        let unitImageWidth = (frameWidth - 16 ) / 3
        self.rightLargeImageWidth.constant = unitImageWidth * 2 + 8
        self.leftStackViewWidth.constant = unitImageWidth
        
        self.layoutIfNeeded()
    }}
