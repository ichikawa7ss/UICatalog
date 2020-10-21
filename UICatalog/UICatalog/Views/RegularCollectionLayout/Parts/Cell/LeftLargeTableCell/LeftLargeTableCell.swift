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
    @IBOutlet private weak var largeItemView: WEARItemView!
    @IBOutlet private weak var smallTopImageView: UIImageView!
    @IBOutlet private weak var smallBottomImageView: UIImageView!
    
    var smallImageWidth: CGFloat?
    var smallImageHeight: CGFloat?

    var largeImageWidth: CGFloat?
    var largeImageHeight: CGFloat?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let frameWidth = UIScreen.main.bounds.width - (8 * 2)
        let unitImageWidth = (frameWidth - 16 ) / 3
        self.leftLargeImageWidth.constant = unitImageWidth * 2 + 8
        self.rightStackViewWidth.constant = unitImageWidth
        
        self.smallImageWidth = unitImageWidth
        self.smallImageHeight = smallImageWidth!  * 332 / 262
        
        self.largeImageWidth = unitImageWidth * 2 + 8
        self.largeImageHeight = self.largeImageWidth! * 332 / 262
        
        self.layoutIfNeeded()
    }
    
    func configure(cellId: Int) {
        let initalId = cellId * 3 + 1
        self.largeItemView.configure(imageId: initalId)
        self.smallTopImageView.loadRandomImage(id: initalId + 1, width: Int(smallImageWidth ?? 0), height: Int(smallImageHeight ?? 0))
        self.smallBottomImageView.loadRandomImage(id: initalId + 2, width: Int(smallImageWidth ?? 0), height: Int(smallImageHeight ?? 0))
    }
}
