//
//  Bundle+.swift
//  UICatalog
//
//  Created by ichikawa on 2020/09/21.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import Foundation
import UIKit

extension Bundle {

    static func loadView(instance: UIView) -> UIView? {
        let t = type(of: instance)
        let bundle = Bundle(for: t)
        let nib = UINib(nibName: String(describing: t), bundle: bundle)
        return nib.instantiate(withOwner: instance, options: nil).first as? UIView
    }
}
