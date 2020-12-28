//
//  SwipableViewSetting.swift
//  UICatalog
//
//  Created by ichikawa on 2020/12/28.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

// SwipableViewのデザインに関する設定値を管理するprotocol
protocol SwipableViewSetting {
    
    /// カード用Viewの幅
    static var cardSetViewWidth: CGFloat { get }

    /// カード用Viewの高さ
    static var cardSetViewHeight: CGFloat { get }
    
    /// X方向のスワイプを許容する
    static var swipableXThresholdLength: CGFloat { get }

    /// Y方向のスワイプを許容する割合
    static var swipableYThresholdLength: CGFloat { get }
    
    static var durationOfReturnOriginal: TimeInterval { get }

    static var durationOfSwipeOut: TimeInterval { get }

}

final class SwipableViewDefaultSetting: SwipableViewSetting {
   
    static var cardSetViewWidth: CGFloat = 344
    
    static var cardSetViewHeight: CGFloat = 530

    static var swipableXThresholdLength: CGFloat =  0.7 * UIScreen.main.bounds.width / 2
    
    static var swipableYThresholdLength: CGFloat = 0.7 * UIScreen.main.bounds.height / 2

    static var durationOfReturnOriginal: TimeInterval = 0.2

    static var durationOfSwipeOut: TimeInterval = 0.2
}
