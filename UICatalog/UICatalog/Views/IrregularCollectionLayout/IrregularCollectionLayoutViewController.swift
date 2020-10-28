//
//  IrregularCollectionLayoutViewController.swift
//  UICatalog
//
//  Created by ichikawa on 2020/10/28.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

final class IrregularCollectionLayoutViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView! {
        willSet {
            newValue.register(IrregularCollectionViewCell.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension IrregularCollectionLayoutViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionViewCell(collectionView.dequeueReusableCell(for: indexPath))
        return cell
    }
    
    private func collectionViewCell(_ cell: IrregularCollectionViewCell) -> IrregularCollectionViewCell {
        return cell
    }
}
