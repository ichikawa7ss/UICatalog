//
//  BaseView.swift
//  UICatalog
//
//  Created by ichikawa on 2020/09/21.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import Foundation
import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    internal func commonInit() {
        guard let view = Bundle.loadView(instance: self) else {
            return
        }
        self.addSubview(view)
        view.matchParent(self)
    }
}
