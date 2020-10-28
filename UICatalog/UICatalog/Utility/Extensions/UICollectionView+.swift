//
//  UICollectionView+.swift
//  UICatalog
//
//  Created by ichikawa on 2020/10/28.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

extension UICollectionView {

    func register<T: UICollectionViewCell>(_ cellType: T.Type) {
        self.register(cellType.nib, forCellWithReuseIdentifier: cellType.className)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath) as! T
    }
}
