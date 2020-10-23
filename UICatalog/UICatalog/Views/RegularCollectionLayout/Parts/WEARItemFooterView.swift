//
//  WEARItemFooterView.swift
//  UICatalog
//
//  Created by ichikawa on 2020/09/30.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

final class WEARItemFooterView: BaseView {
    
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var label: UILabel!
    
    func configure(imageId: Int) {
        self.label.text = "No.\(imageId)"
        self.profileImageView.loadRandomImage(id: imageId,
                                              width: Int(self.profileImageView.frame.size.width),
                                              height: Int(self.profileImageView.frame.size.height))
    }
}
