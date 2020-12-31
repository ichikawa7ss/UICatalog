//
//  SwipableViewController.swift
//  UICatalog
//
//  Created by ichikawa on 2020/12/28.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

final class SwipableViewController: UIViewController {

    private var imgURLs = [String](repeating: "", count: 10)

    @IBOutlet private weak var swipableBaseView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
}

// MARK: setup
extension SwipableViewController {
    
    private func setup() {
        self.imgURLs.enumerated().map { args in
            self.setupSwipableView(args.offset)
        }
        self.setUserInteraction()
    }
    
    /// Viewの設定
    /// - Parameter offset: データのoffset
    private func setupSwipableView(_ offset: Int) {
        
        let swipableCardView = SwipableView()
        swipableCardView.delegate = self
        swipableCardView.setData(offset)
        
        if let firstView = self.swipableBaseView.subviews.first {
            self.swipableBaseView.insertSubview(swipableCardView, belowSubview: firstView)
			// 最前面のView以外は指定分縮小しておく
            swipableCardView.setMinimamScale()
        }
        else {
            self.swipableBaseView.addSubview(swipableCardView)
        }
    }
    
    // 画面上にあるカードの山のうち、一番上にあるViewのみを操作できるようにする
    private func setUserInteraction() {
        self.swipableBaseView.subviews.enumerated().forEach { args in
            if let view = args.element as? SwipableView {
                let isUserInteractionEnabled = args.offset == self.swipableBaseView.subviews.count - 1
                view.setUserInteraction(isUserInteractionEnabled)
            }
        }
    }
}

extension SwipableViewController: SwipableViewSetDelegate {

    func beganDragging(_ swipableView: SwipableView) {
        print("beganDragging")
    }
    
    func swipableView(_ swipableView: SwipableView, updatePosition: CGPoint) {
        let dx = updatePosition.x - SwipableViewDefaultSetting.cardViewWidth / 2
        let dy = updatePosition.y - SwipableViewDefaultSetting.cardViewHeight / 2
        let ds = hypot(dx, dy)
        let base = SwipableViewDefaultSetting.upperTransitionLengthWhenExpandedFrontView
        let scale = SwipableViewDefaultSetting.lowerLimitViewScaling

        let ratio = min(((ds / base) * (1.0 - scale) + scale), 1.0)
        if let targetView = self.swipableBaseView.subviews[safe: self.swipableBaseView.subviews.count - 2] as? SwipableView {
            targetView.scaleSizeBackView(ratio)
        }
        print("updatePosition \(updatePosition)")
    }
    
    func swipedLeftPosition(_ swipableView: SwipableView) {
        print("swipedLeftPosition")
        self.setUserInteraction()
    }
    
    func swipedRightPosition(_ swipableView: SwipableView) {
        print("swipedRightPosition")
        self.setUserInteraction()
    }
    
    func returnToOriginalPosition(_ swipableView: SwipableView) {
        print("returnToOriginalPosition")
        if let targetView = self.swipableBaseView.subviews[safe: self.swipableBaseView.subviews.count - 2] as? SwipableView {
            targetView.setMinimamScale()
        }
    }
}
