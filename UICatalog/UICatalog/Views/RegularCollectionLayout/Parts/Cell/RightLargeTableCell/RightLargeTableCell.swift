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
    @IBOutlet private weak var largeImageView: UIImageView!
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
        
        self.rightLargeImageWidth.constant = unitImageWidth * 2 + 8
        self.leftStackViewWidth.constant = unitImageWidth
        
        self.smallImageWidth = unitImageWidth
        self.smallImageHeight = smallImageWidth!  * 332 / 262
        
        self.largeImageWidth = unitImageWidth * 2 + 8
        self.largeImageHeight = self.largeImageWidth! * 332 / 262

        self.layoutIfNeeded()
    }
    
    func configure(cellId: Int) {
        let initalId = cellId * 3 + 1
        self.smallTopImageView.loadRandomImage(id: initalId, width: Int(largeImageWidth ?? 0), height: Int(largeImageHeight ?? 0))
        self.smallBottomImageView.loadRandomImage(id: initalId + 1, width: Int(smallImageWidth ?? 0), height: Int(smallImageHeight ?? 0))
        self.largeImageView.loadRandomImage(id: initalId + 2, width: Int(smallImageWidth ?? 0), height: Int(smallImageHeight ?? 0))
    }
}
