//
//  SwipableViewSetDelegate.swift
//  UICatalog
//
//  Created by ichikawa on 2020/12/28.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

protocol SwipableViewSetDelegate {

    // ドラッグ開始時に実行されるアクション
    func beganDragging(_ swipableView: SwipableView)

    // 位置の変化が生じた際に実行されるアクション
    func swipableView(_ swipableView: SwipableView, updatePosition: CGPoint)

    // 左側へのスワイプ動作が完了した場合に実行されるアクション
    func swipedLeftPosition(_ swipableView: SwipableView)

    // 右側へのスワイプ動作が完了した場合に実行されるアクション
    func swipedRightPosition(_ swipableView: SwipableView)

    // 元の位置に戻る動作が完了したに実行されるアクション
    func returnToOriginalPosition(_ swipableView: SwipableView)
}

