//
//  WEARItemView.swift
//  UICatalog
//
//  Created by ichikawa on 2020/09/30.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

final class WEARItemView: BaseView {
    
    @IBOutlet private weak var footerView: WEARItemFooterView!
    @IBOutlet private weak var itemImageView: UIImageView!
    
    func configure(imageId: Int) {
        self.itemImageView.loadRandomImage(id: imageId, width: Int(self.frame.width), height: Int(self.frame.height - 28))
        let footerImageId = imageId + 100
        self.footerView.configure(imageId: footerImageId)
    }
}
