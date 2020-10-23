//
//  RightLargeTableCell.swift
//  UICatalog
//
//  Created by ichikawa on 2020/10/14.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

class RightLargeTableCell: UITableViewCell {

    @IBOutlet private weak var rightLargeItemWidth: NSLayoutConstraint!
    @IBOutlet private weak var leftStackViewWidth: NSLayoutConstraint!
    @IBOutlet private weak var largeItemView: WEARItemView!
    @IBOutlet private weak var smallTopItemView: WEARItemView!
    @IBOutlet private weak var smallBottomItemView: WEARItemView!
    
    var smallImageWidth: CGFloat?
    var smallImageHeight: CGFloat?

    var largeImageWidth: CGFloat?
    var largeImageHeight: CGFloat?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let frameWidth = UIScreen.main.bounds.width - (8 * 2)
        let unitImageWidth = (frameWidth - 16 ) / 3
        
        self.rightLargeItemWidth.constant = unitImageWidth * 2 + 8
        self.leftStackViewWidth.constant = unitImageWidth
        
        self.smallImageWidth = unitImageWidth
        self.smallImageHeight = smallImageWidth!  * 332 / 262
        
        self.largeImageWidth = unitImageWidth * 2 + 8
        self.largeImageHeight = self.largeImageWidth! * 332 / 262

        self.layoutIfNeeded()
    }
    
    func configure(cellId: Int) {
        let initalId = cellId * 3 + 1
        self.smallTopItemView.configure(imageId: initalId)
        self.smallBottomItemView.configure(imageId: initalId + 1)
        self.largeItemView.configure(imageId: initalId + 2)
    }
}
