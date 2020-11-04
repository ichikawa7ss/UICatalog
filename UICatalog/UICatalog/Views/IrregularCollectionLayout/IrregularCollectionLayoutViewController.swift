//
//  IrregularCollectionLayoutViewController.swift
//  UICatalog
//
//  Created by ichikawa on 2020/10/28.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

final class IrregularCollectionLayoutViewController: UIViewController {

    private let data = IrregularCollectionContentsModelGenarator.generate()
    
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

extension IrregularCollectionLayoutViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let collectionViewWidth = collectionView.bounds.width
        let itemPerRow = 3
        
        let spacings = 8 * CGFloat(itemPerRow - 1)
        // 計算の兼ね合いで横幅が若干大きくなってしまうことがあるので、小数点以下は切り捨てる
        let width = floor((collectionViewWidth - 8 * 2 - spacings) / CGFloat(itemPerRow))
        let defaultSize = CGSize(width: 262, height: 332)
        let height = defaultSize.height * (width / defaultSize.width)
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
   }
}
