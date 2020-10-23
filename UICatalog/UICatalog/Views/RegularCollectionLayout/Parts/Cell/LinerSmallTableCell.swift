//
//  LinerTableCellTableViewCell.swift
//  UICatalog
//
//  Created by ichikawa on 2020/10/14.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

class LinerSmallTableCell: UITableViewCell {

    @IBOutlet private weak var leftItemView: WEARItemView!
    @IBOutlet private weak var middleItemView: WEARItemView!
    @IBOutlet private weak var rightItemView: WEARItemView!

    var imageWidth: CGFloat?
    var imageHeight: CGFloat?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let frameWidth = UIScreen.main.bounds.width - (8 * 2)
        let unitImageWidth = (frameWidth - 16 ) / 3

        self.imageWidth = unitImageWidth
        self.imageHeight = imageWidth!  * 332 / 262
                
        self.layoutIfNeeded()
    }
    
    func configure(cellId: Int) {
        let initalId = cellId * 3 + 1
        self.leftItemView.configure(imageId: initalId)
        self.middleItemView.configure(imageId: initalId + 1)
        self.rightItemView.configure(imageId: initalId + 2)
    }
}
