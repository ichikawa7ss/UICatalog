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
	/// 上下左右のinset
    private let inset: CGFloat = 8
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
    
    lazy var unitSize: CGSize = {
        guard attributesArray.isEmpty, let collectionView = collectionView else {
            return CGSize()
        }
        let itemPerRow = 3
        let collectionViewWidth = collectionView.bounds.width
        let spacings = interitemSpacing * CGFloat(itemPerRow - 1)

        let unitWidth = floor((collectionViewWidth - 8 * 2 - spacings) / CGFloat(itemPerRow))
        let defaultSize = CGSize(width: 262, height: 332)
        let unitHeight = defaultSize.height * (unitWidth / defaultSize.width)
        return CGSize(width: unitWidth, height: unitHeight)
    }()
    
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
        
//        var xOffsets = [CGFloat]() // 各コンテンツのx座標
//        var yOffsets = [CGFloat]() // 各コンテンツのy座標
//        var widthArray = [CGFloat]() // 各コンテンツの幅
//        var heightArray = [CGFloat]() // 各コンテンツの高さ

        var frameArray = [CGRect]()
        var rowCount = 0
        var columnCount = 0

        func resetRow() {
            rowCount = 0
        }
        
        rowCount = layouts.count / 3
        var tmpLayouts: [ContentsType] = layouts
        var yOffset: CGFloat = 0
        for i in 0...rowCount {
            let threeLayouts = tmpLayouts.prefix(3)
            if i != rowCount {
                tmpLayouts.removeFirst(3)
            let ret = self.calcCellRectByThreeCells(yOffset,
                                                    first: threeLayouts[0],
                                                    second: threeLayouts[1],
                                                    third: threeLayouts[2])
            frameArray.append(ret.first)
            frameArray.append(ret.second)
            frameArray.append(ret.third)
            yOffset = ret.third.maxY
            }
        }
        
        for index in 0..<collectionView.numberOfItems(inSection: 0) {
            // 計算したframeからattributesArrayを算出
            let indexPath = IndexPath(item: index, section: 0)
            let insetFrame = frameArray[index].insetBy(dx: interitemSpacing, dy: linespacing)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            attributesArray.append(attributes)
        }

        // 全体サイズを入れておく
        let lastIndex = layouts.count - 1
        self.contentWidth = collectionViewWidth
        self.contentHeight = frameArray[lastIndex].maxY + self.inset
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

extension IrregularCollectionViewLayout {
    
    /// セルのサイズを三つずつの単位で計算する
    private func calcCellRectByThreeCells(_ yOffset: CGFloat,
                                          first: ContentsType,
                                          second: ContentsType?,
                                          third: ContentsType?) -> UnitCellRect {
        // 三つともsmallの場合
        if case .small = first, case .small = second, case .small = third {
            return normalUnitCellRect(yOffset)
        }
        
        if case .large = first {
            return firstLargeUnitCellRect(yOffset)
        }
        if case .large = second {
            return secondLargeUnitCellRect(yOffset)
        }
        if case .large = third {
            return thirdLargeUnitCellRect(yOffset)
        }
        
        return normalUnitCellRect(yOffset)
    }
    
    // 全て基本サイズの小さいサイズが横に三つ並んだ形
    private func normalUnitCellRect(_ yOffset: CGFloat) -> UnitCellRect {
        let firstRect = CGRect(x: self.inset, y: yOffset + self.inset,
                               width: self.unitSize.width, height: self.unitSize.height)
        let secondRect = CGRect(x: firstRect.maxX + self.inset, y: yOffset + self.inset,
                                width: self.unitSize.width, height: self.unitSize.height)
        let thirdRect = CGRect(x: secondRect.maxX + self.inset, y: yOffset + self.inset,
                               width: self.unitSize.width, height: self.unitSize.height)
        return UnitCellRect(first: firstRect, second: secondRect, third: thirdRect)
    }
    
    // firstがlargeのときは左のセルが大きい形
    private func firstLargeUnitCellRect(_ yOffset: CGFloat) -> UnitCellRect {
        let firstRect = CGRect(x: self.inset, y: yOffset + self.inset,
                               width: self.unitSize.width * 2 + self.linespacing,
                               height: self.unitSize.height * 2 + self.interitemSpacing)
        let secondRect = CGRect(x: firstRect.maxX + self.inset, y: yOffset + self.inset,
                                width: self.unitSize.width, height: self.unitSize.height)
        let thirdRect = CGRect(x: firstRect.maxX + self.inset, y: secondRect.maxY + self.inset,
                               width: self.unitSize.width, height: self.unitSize.height)
        return UnitCellRect(first: firstRect, second: secondRect, third: thirdRect)
    }
    
    // secondがlargeのときは右のセルが大きい形
    private func secondLargeUnitCellRect(_ yOffset: CGFloat) -> UnitCellRect {
        let firstRect = CGRect(x: self.inset, y: yOffset + self.inset,
                               width: self.unitSize.width, height: self.unitSize.height)
        let secondRect = CGRect(x: firstRect.maxX + self.inset, y: yOffset + self.inset,
                                width: self.unitSize.width * 2 + self.linespacing,
                                height: self.unitSize.height * 2 + self.interitemSpacing)
        let thirdRect = CGRect(x: self.inset, y: firstRect.maxY + self.inset,
                               width: self.unitSize.width, height: self.unitSize.height)
        return UnitCellRect(first: firstRect, second: secondRect, third: thirdRect)
    }
    
    // thirdがlargeのときは右のセルが大きい形
    private func thirdLargeUnitCellRect(_ yOffset: CGFloat) -> UnitCellRect {
        let firstRect = CGRect(x: self.inset, y: yOffset + self.inset,
                               width: self.unitSize.width, height: self.unitSize.height)
        let secondRect = CGRect(x: self.inset, y: firstRect.maxY + self.inset,
                                width: self.unitSize.width, height: self.unitSize.height)
        let thirdRect = CGRect(x: firstRect.maxX + self.inset, y: yOffset + self.inset,
                               width: self.unitSize.width * 2 + self.linespacing,
                               height: self.unitSize.height * 2 + self.interitemSpacing)
        return UnitCellRect(first: firstRect, second: secondRect, third: thirdRect)
    }
    
    struct UnitCellRect {
        let first: CGRect
        let second: CGRect
        let third: CGRect
    }
}
