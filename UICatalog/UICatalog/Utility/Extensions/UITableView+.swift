//
//  UITableView+.swift
//  UICatalog
//
//  Created by ichikawa on 2020/10/14.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

extension UITableView {

    func register<T: UITableViewCell>(_ cellType: T.Type) {
        self.register(cellType.nib, forCellReuseIdentifier: cellType.className)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: T.className, for: indexPath) as! T
    }
}
