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
    /// 行間の長さ(縦の間隔)
    private let linespacing: CGFloat = 8
    /// セル同士の間隔(横の間隔)
    private let interitemSpacing: CGFloat = 8
    private var attributesArray: [UICollectionViewLayoutAttributes] = []
    private let layouts: [ContentsType]
    
    /// 全体のコンテントタイプの配列をセットする
    init(layouts: [ContentsType]) {
        self.layouts = layouts
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: self.contentWidth, height: self.contentHeight)
    }
    
    /// 前もってセルの位置情報を計算しておく
    /// ここで計算してないとカクつきの原因になったりする
    /// indexPathに応じたコンテンツタイプをself.layoutsが持ってるので、そこからindexPathに応じたitemsRecを計算する
    override func prepare() {
        guard attributesArray.isEmpty, let collectionView = collectionView else { return }
        let itemPerRow = 3
        let collectionViewWidth = collectionView.bounds.width
        let spacings = interitemSpacing * CGFloat(itemPerRow - 1)

        let unitWidth = floor((collectionViewWidth - 8 * 2 - spacings) / CGFloat(itemPerRow))
        let defaultSize = CGSize(width: 262, height: 332)
        let unitHeight = defaultSize.height * (unitWidth / defaultSize.width)
        
        var xOffsets = [CGFloat]() // 各コンテンツのx座標
        var yOffsets = [CGFloat]() // 各コンテンツのy座標
        var widthArray = [CGFloat]() // 各コンテンツの幅
        var heightArray = [CGFloat]() // 各コンテンツの高さ

        var rowCount = 0
        var columnCount = 0

        func resetRow() {
            rowCount = 0
        }
        
        for layout in layouts {

            // largeがきた場合
            if case .large = layout {
                if rowCount == 0 {
                    xOffsets.append(0)
                    yOffsets.append(CGFloat(columnCount) * (unitHeight + linespacing))
                    widthArray.append(CGFloat(unitWidth) * 2)
                    heightArray.append(CGFloat(unitHeight) * 2)
                    
                    rowCount += 2
                    columnCount += 2
                    continue
                }
                
                if rowCount == 1 {
                    xOffsets.append(CGFloat(columnCount) * (unitWidth + interitemSpacing))
                    yOffsets.append(CGFloat(columnCount) * (unitHeight + linespacing))
                    widthArray.append(CGFloat(unitWidth) * 2)
                    heightArray.append(CGFloat(unitHeight) * 2)
                    
                    // 行は最初に戻す
                    resetRow()
                    columnCount += 2
                    continue
                }
            }

            // smallがきた場合
            if case .small = layout {
                if rowCount == 0 {
                    xOffsets.append(0)
                    yOffsets.append(CGFloat(columnCount) * (unitHeight + linespacing))
                    widthArray.append(CGFloat(unitWidth))
                    heightArray.append(CGFloat(unitHeight))
                    
                    rowCount += 1
                    continue
                }
                
                if rowCount == 1 {
                    xOffsets.append(CGFloat(columnCount) * (unitWidth + interitemSpacing))
                    yOffsets.append(CGFloat(columnCount) * (unitHeight + linespacing))
                    widthArray.append(CGFloat(unitWidth))
                    heightArray.append(CGFloat(unitHeight))
                    
                    rowCount += 1
                    continue
                }
                
                if rowCount == 2 {
                    xOffsets.append(CGFloat(columnCount) * (unitWidth + interitemSpacing))
                    yOffsets.append(CGFloat(columnCount) * (unitHeight + linespacing))
                    widthArray.append(CGFloat(unitWidth))
                    heightArray.append(CGFloat(unitHeight))
                    
                    columnCount += 1
                    resetRow()
                    continue
                }
            }
        }
            
        for index in 0..<collectionView.numberOfItems(inSection: 0) {
            // 計算したframeからattributesArrayを算出
            let indexPath = IndexPath(item: index, section: 0)
            let frame = CGRect(x: xOffsets[index], y: yOffsets[index], width: widthArray[index], height: heightArray[index])
            let insetFrame = frame.insetBy(dx: interitemSpacing, dy: linespacing)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            attributesArray.append(attributes)
        }

        // 全体サイズを入れておく
        let lastIndex = layouts.count - 1
        self.contentWidth = collectionViewWidth
        self.contentHeight = yOffsets[lastIndex] + unitHeight + 8
    }
    
    /// 各indexPathに対してのUICollectionViewLayoutAttributesを返却
    /// UICollectionViewLayoutAttributesは、セルサイズや位置情報のプロパティを保持してる
    /// prepare()で作成した配列から、セルサイズと位置情報を含んだUICollectionViewLayoutAttributesを生成する
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.attributesArray[indexPath.row]
    }
    
    /// 引数のrectに含まれる全てのセルやviewのUICollectionViewLayoutAttributesの配列を返却
    /// 返却されるUICollectionViewLayoutAttributesに従い、各セルのレイアウトが作成される
    /// layoutAttributesForItem(at:)で取得したrect範囲内のUICollectionViewLayoutAttributesの配列を返す
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in attributesArray where attributes.frame.intersects(rect) {
            visibleLayoutAttributes.append(attributes)
        }
        return visibleLayoutAttributes
    }
}
