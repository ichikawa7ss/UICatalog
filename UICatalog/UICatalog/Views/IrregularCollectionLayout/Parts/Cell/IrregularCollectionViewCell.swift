//
//  IrregularCollectionViewCell.swift
//  UICatalog
//
//  Created by ichikawa on 2020/10/28.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

class IrregularCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var itemView: WEARItemView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(cellId: Int, size: CGSize) {
        self.itemView.configure(imageId: cellId, width: Int(size.width), height: Int(size.height))
    }
}
