//
//  WEARItemCollectionCell.swift
//  UICatalog
//
//  Created by ichikawa on 2021/06/23.
//  Copyright © 2021 ichikawa. All rights reserved.
//

import UIKit

final class WEARItemCollectionCell: UICollectionViewCell {

    @IBOutlet private weak var itemView: WEARItemView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(cellId: Int) {
        self.itemView.configure(imageId: cellId, width: Int(WEARItemCollectionCell.size.width), height: Int(WEARItemCollectionCell.size.height))
    }
}

extension WEARItemCollectionCell {

    static var size: CGSize {
        let collectionViewWidth = UIScreen.main.bounds.width
        let itemPerRow = 2
        let spacing: CGFloat = 8
        let sideMargin: CGFloat = 8 * 2
        let defaultSize = CGSize(width: 200, height: 320)
        let spacings = spacing * CGFloat(itemPerRow - 1)
        // 計算の兼ね合いで横幅が若干大きくなってしまうことがあるので、小数点以下は切り捨てる
        let width = floor((collectionViewWidth - sideMargin - spacings) / CGFloat(itemPerRow))
        let height = defaultSize.height * (width / defaultSize.width)
        return CGSize(width: width, height: height)
    }
}
