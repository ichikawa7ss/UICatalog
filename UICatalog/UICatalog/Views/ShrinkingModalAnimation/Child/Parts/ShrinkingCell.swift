//
//  ShrinkingCell.swift
//  UICatalog
//
//  Created by ichikawa on 2021/03/31.
//  Copyright © 2021 ichikawa. All rights reserved.
//

import UIKit

class ShrinkingCell: UITableViewCell {

    @IBOutlet private weak var shrinkingImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure() {
        self.shrinkingImageView.loadRandomImage(id: 100, width: 375, height: 667)
    }
}
