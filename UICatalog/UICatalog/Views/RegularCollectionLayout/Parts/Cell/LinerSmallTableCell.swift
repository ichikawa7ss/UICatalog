//
//  LinerTableCellTableViewCell.swift
//  UICatalog
//
//  Created by ichikawa on 2020/10/14.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

class LinerSmallTableCell: UITableViewCell {

    @IBOutlet private weak var leftImageView: UIImageView!
    @IBOutlet private weak var middleImageView: UIImageView!
    @IBOutlet private weak var lightImageView: UIImageView!

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
        self.leftImageView.loadRandomImage(id: initalId, width: Int(imageWidth ?? 0), height: Int(imageHeight ?? 0))
        self.middleImageView.loadRandomImage(id: initalId + 1, width: Int(imageWidth ?? 0), height: Int(imageHeight ?? 0))
        self.lightImageView.loadRandomImage(id: initalId + 2, width: Int(imageWidth ?? 0), height: Int(imageHeight ?? 0))
    }
}
