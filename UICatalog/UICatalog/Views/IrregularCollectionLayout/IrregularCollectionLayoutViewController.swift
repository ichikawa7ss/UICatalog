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
        self.setupContents()
    }
    
    func setupContents() {
        if !self.isEnableLayouts(self.data) {
         	assertionFailure("Largeサイズのコンテンツが二回連続で入るとコンテンツが正しく表示されなくなります")
        }
        let layout = IrregularCollectionViewLayout(layouts: data)
        self.collectionView.collectionViewLayout = layout
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
        layouts.threePair().forEach { one, two, three in
            // 連続する三つのコンテンツの中に二つ以上largeがあったら不正なレイアウト
            if [one, two, three].filter({ $0 == .large }).count >= 2 {
                ret = false
            }
        }
        return ret
    }
}
