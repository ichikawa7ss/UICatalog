//
//  RightLargeTableCell.swift
//  UICatalog
//
//  Created by ichikawa on 2020/10/14.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

final class LeftLargeTableCell: UITableViewCell {

    @IBOutlet private weak var leftLargeImageWidth: NSLayoutConstraint!
    @IBOutlet private weak var rightStackViewWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let frameWidth = UIScreen.main.bounds.width - (8 * 2)
        let unitImageWidth = (frameWidth - 16 ) / 3
        self.leftLargeImageWidth.constant = unitImageWidth * 2 + 8
        self.rightStackViewWidth.constant = unitImageWidth
        
        self.layoutIfNeeded()
    }
}
