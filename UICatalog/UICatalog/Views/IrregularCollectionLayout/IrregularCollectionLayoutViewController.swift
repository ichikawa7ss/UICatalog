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
        if self.isEnableLayouts(data) {
            let layout = IrregularCollectionViewLayout(layouts: data)
            self.collectionView.collectionViewLayout = layout
        }
    }
}

extension IrregularCollectionLayoutViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionViewCell(collectionView.dequeueReusableCell(for: indexPath))
        return cell
    }
    
    private func collectionViewCell(_ cell: IrregularCollectionViewCell) -> IrregularCollectionViewCell {
        return cell
    }
}

extension IrregularCollectionLayoutViewController {

    /// 渡された配列がレイアウト可能かを判定する
    /// 仕様：largeの次は2回はsmallが入ってはいけない
    private func isEnableLayouts(_ layouts: [ContentsType]) -> Bool {
        var ret = true
        // largeの次は連続でsmallが入ったら
        layouts.pair().forEach { one, afterOne in
            guard let afterOne = afterOne else {
                return
            }
            
            if case .large = one, case .large = afterOne {
                ret = false
            }
        }
        return ret
    }
}
