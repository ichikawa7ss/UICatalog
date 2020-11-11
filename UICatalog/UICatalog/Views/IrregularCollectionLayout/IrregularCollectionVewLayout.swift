//
//  IrregularCollectionVewLayout.swift
//  UICatalog
//
//  Created by ichikawa on 2020/11/11.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

final class IrregularCollectionViewLayout: UICollectionViewLayout {

    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat = 0
    private var itemsRec: [CGRect] = []
    private let layouts: [ContentsType]

    /// 全体のコンテントタイプの配列をセットする
    init(layouts: [ContentsType]) {
        self.layouts = layouts
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 前もってセルの位置情報を計算しておく
    /// ここで計算してないとカクつきの原因になったりする
    /// indexPathに応じたコンテンツタイプをself.layoutsが持ってるので、そこからindexPathに応じたitemsRecを計算する
    override func prepare() {
        guard let collectionView = collectionView else { return }
        let collectionViewWidth = collectionView.bounds.width
        let itemPerRow = 3

        let spacings = CGFloat(8)
        // 計算の兼ね合いで横幅が若干大きくなってしまうことがあるので、小数点以下は切り捨てる
        let unitWidth = floor((collectionViewWidth - 8 * 2 - spacings) / CGFloat(itemPerRow))
        let width = floor((collectionViewWidth - 8 * 2 - spacings) - unitWidth)
        let defaultSize = CGSize(width: 262, height: 332)
        let height = defaultSize.height * (width / defaultSize.width)
        self.contentWidth = width
        self.contentHeight = height
    }
    
    /// 各indexPathに対してのUICollectionViewLayoutAttributesを返却
    /// UICollectionViewLayoutAttributesは、セルサイズや位置情報のプロパティを保持してる
    /// prepare()で作成した配列から、セルサイズと位置情報を含んだUICollectionViewLayoutAttributesを生成する
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
		return UICollectionViewLayoutAttributes()
    }
    
    /// 引数のrectに含まれる全てのセルやviewのUICollectionViewLayoutAttributesの配列を返却
    /// 返却されるUICollectionViewLayoutAttributesに従い、各セルのレイアウトが作成される
    /// layoutAttributesForItem(at:)で取得したrect範囲内のUICollectionViewLayoutAttributesの配列を返す
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return []
    }

    /// カスタムレイアウトのスクロール量を判断するのに使用
    /// カスタムレイアウト全体のCGSizeを返却
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
}
