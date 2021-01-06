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
    static var cardViewWidth: CGFloat { get }

    /// カード用Viewの比率（高さ/幅）
    static var cardViewAspectRatio: CGFloat { get }
    
    /// shadowOffset
    static var shadowOffset: CGSize { get }

    /// shadowの濃さ
    static var shadowOpacity: CGFloat { get }
    
    /// shadowのぼかし
    static var shadowBlur: CGFloat { get }

    /// X方向のスワイプを許容する
    static var swipableXThresholdLength: CGFloat { get }

    /// Y方向のスワイプを許容する割合
    static var swipableYThresholdLength: CGFloat { get }
    
    /// 最前面のViewに対する下のViewのサイズの最も低いスケール尺度
    static var lowerLimitViewScaling: CGFloat { get }

    /// スワイプ時にスケールする画面が最大のSizeになるときの重心の移動距離
    static var upperTransitionLengthWhenExpandedFirstView: CGFloat { get }

    /// 先頭Viewの下のViewが縮小するまでのアニメーション時間
    static var durationOfReturnOriginalScaling: TimeInterval { get }

    /// 先頭Viewのスワイプ時に下のViewが縮小するアニメーション時間
    static var durationOfScalingWhenPositionUpdated: TimeInterval { get }

    /// もとの場所に戻るまでのアニメーション時間
    static var durationOfReturnOriginal: TimeInterval { get }

    /// 外にスワイプアウトするときのアニメーション時間
    static var durationOfSwipeOut: TimeInterval { get }

}

final class SwipableViewDefaultSetting: SwipableViewSetting {
   
    static var cardViewWidth: CGFloat = UIScreen.main.bounds.width - 32
    
    static var cardViewAspectRatio: CGFloat = 530 / 344

    static var shadowOffset: CGSize = CGSize(width: 0.0, height: 2.0)
    
    static var shadowOpacity: CGFloat = 0.25
    
    static var shadowBlur: CGFloat = 11
    
    static var swipableXThresholdLength: CGFloat = 0.8 * UIScreen.main.bounds.width / 2
    
    static var swipableYThresholdLength: CGFloat = 0.8 * UIScreen.main.bounds.height / 2

    static var lowerLimitViewScaling: CGFloat = 0.95
    
    static var upperTransitionLengthWhenExpandedFirstView: CGFloat = 200

    static var durationOfReturnOriginalScaling: TimeInterval = 0.3

    static var durationOfScalingWhenPositionUpdated: TimeInterval = 0.01
    
    static var durationOfReturnOriginal: TimeInterval = 0.2

    static var durationOfSwipeOut: TimeInterval = 0.2
}
