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
    
    lazy var doubleSize: CGSize = {
        return CGSize(width: (self.unitSize.width * 2 + self.interitemSpacing),
                      height: (self.unitSize.height * 2 + self.linespacing))
    }()
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: self.contentWidth, height: self.contentHeight)
    }
    
    /// 前もってセルの位置情報を計算しておく
    /// ここで計算してないとカクつきの原因になったりする
    /// indexPathに応じたコンテンツタイプをself.layoutsが持ってるので、そこからindexPathに応じたframeを計算する
    override func prepare() {
        guard attributesArray.isEmpty, let collectionView = collectionView, !layouts.isEmpty else { return }
        let itemPerRow = 3
        let collectionViewWidth = collectionView.bounds.width
        
        var frameArray = [CGRect]()
        let rowCount = (layouts.count + itemPerRow - 1) / itemPerRow
        var tmpLayouts: [ContentsType] = layouts
        var yOffset: CGFloat = 0
        for _ in 0...rowCount {
            let threeLayouts = tmpLayouts.prefix(itemPerRow).map { $0 }
            let rects = self.calcCellRectByThreeCells(yOffset, contents: threeLayouts)
            _ = rects.map { frameArray.append($0) }
            yOffset = frameArray.last?.maxY ?? 0
            if tmpLayouts.count >= itemPerRow {
                tmpLayouts.removeSubrange(0..<itemPerRow)
            }
        }
        
        for index in 0..<collectionView.numberOfItems(inSection: 0) {
            // 計算したframeからattributesArrayを算出
            guard let insetFrame = frameArray[safe: index] else {
                continue
            }
            let indexPath = IndexPath(item: index, section: 0)
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
    private func calcCellRectByThreeCells(_ yOffset: CGFloat, contents: [ContentsType]) -> [CGRect] {
        
        guard let first = contents[safe: 0] else {
            return [] // 最初のコンテンツがなければ空の配列
        }
        
        guard let second = contents[safe: 1] else {
            return singleCellRect(yOffset, type: first) // 一つしかコンテンツがない時のframeを算出
        }

        guard let third = contents[safe: 2] else {
            return doubleCellRect(yOffset, types: [first, second]) // 二つしかコンテンツがない時のframeを算出
        }

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
    
    private func singleCellRect(_ yOffset: CGFloat, type: ContentsType) -> [CGRect] {
        switch type {
        case .small:
            return [CGRect(x: self.inset, y: yOffset + self.inset, width: self.unitSize.width, height: self.unitSize.height)]
        case .large:
            return [CGRect(x: 0, y: yOffset,
                           width: self.unitSize.width * 2 + self.linespacing,
                           height: self.unitSize.height * 2 + self.interitemSpacing)]
        }
    }
    
    private func doubleCellRect(_ yOffset: CGFloat, types: [ContentsType]) -> [CGRect] {
        guard let first = types.first, let second = types[safe: 1] else {
            return []
        }
        switch (first, second) {
        case (.small, .small):
            let first = CGRect(x: self.inset, y: yOffset + self.inset,
                                   width: self.unitSize.width, height: self.unitSize.height)
            let second = CGRect(x: first.maxX + self.inset, y: yOffset + self.inset,
                                    width: self.unitSize.width, height: self.unitSize.height)
            return [first, second]
        case (.small, .large):
            let first = CGRect(x: self.inset, y: yOffset + self.inset,
                                   width: self.unitSize.width, height: self.unitSize.height)
            let second = CGRect(x: first.maxX + self.inset, y: yOffset + self.inset,
                                    width: self.unitSize.width * 2 + self.linespacing,
                                    height: self.unitSize.height * 2 + self.interitemSpacing)
            return [first, second]
        case (.large, .small):
            let first = CGRect(x: self.inset, y: yOffset + self.inset,
                                   width: self.unitSize.width * 2 + self.linespacing,
                                   height: self.unitSize.height * 2 + self.interitemSpacing)
            let second = CGRect(x: first.maxX + self.inset, y: yOffset + self.inset,
                                    width: self.unitSize.width, height: self.unitSize.height)
            return [first, second]
        case (.large, .large):
            fatalError("二つ連続でlargeサイズのコンテンツは並ばない想定です")
        }

    }

    // 全て基本サイズの小さいサイズが横に三つ並んだ形
    private func normalUnitCellRect(_ yOffset: CGFloat) -> [CGRect] {
        let first = CGRect(x: self.inset, y: yOffset + self.inset,
                               width: self.unitSize.width, height: self.unitSize.height)
        let second = CGRect(x: first.maxX + self.inset, y: yOffset + self.inset,
                                width: self.unitSize.width, height: self.unitSize.height)
        let third = CGRect(x: second.maxX + self.inset, y: yOffset + self.inset,
                               width: self.unitSize.width, height: self.unitSize.height)
        return [first, second, third]
    }
    
    // firstがlargeのときは左のセルが大きい形
    private func firstLargeUnitCellRect(_ yOffset: CGFloat) -> [CGRect] {
        let first = CGRect(x: self.inset, y: yOffset + self.inset,
                               width: self.unitSize.width * 2 + self.linespacing,
                               height: self.unitSize.height * 2 + self.interitemSpacing)
        let second = CGRect(x: first.maxX + self.inset, y: yOffset + self.inset,
                                width: self.unitSize.width, height: self.unitSize.height)
        let third = CGRect(x: first.maxX + self.inset, y: second.maxY + self.inset,
                               width: self.unitSize.width, height: self.unitSize.height)
        return [first, second, third]
    }
    
    // secondがlargeのときは右のセルが大きい形
    private func secondLargeUnitCellRect(_ yOffset: CGFloat) -> [CGRect] {
        let first = CGRect(x: self.inset, y: yOffset + self.inset,
                               width: self.unitSize.width, height: self.unitSize.height)
        let second = CGRect(x: first.maxX + self.inset, y: yOffset + self.inset,
                                width: self.unitSize.width * 2 + self.linespacing,
                                height: self.unitSize.height * 2 + self.interitemSpacing)
        let third = CGRect(x: self.inset, y: first.maxY + self.inset,
                               width: self.unitSize.width, height: self.unitSize.height)
        return [first, second, third]
    }
    
    // thirdがlargeのときは右のセルが大きい形
    private func thirdLargeUnitCellRect(_ yOffset: CGFloat) -> [CGRect] {
        let first = CGRect(x: self.inset, y: yOffset + self.inset,
                               width: self.unitSize.width, height: self.unitSize.height)
        let second = CGRect(x: self.inset, y: first.maxY + self.inset,
                                width: self.unitSize.width, height: self.unitSize.height)
        let third = CGRect(x: first.maxX + self.inset, y: yOffset + self.inset,
                               width: self.unitSize.width * 2 + self.linespacing,
                               height: self.unitSize.height * 2 + self.interitemSpacing)
        return [first, second, third]
    }
}
