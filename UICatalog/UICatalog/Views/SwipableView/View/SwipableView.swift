//
//  SwipableView.swift
//  UICatalog
//
//  Created by ichikawa on 2020/12/28.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

class SwipableView: BaseView {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var nationLabel: UILabel!
    @IBOutlet private weak var impressionView: ImpressionView!
    
    var number: Int?
    
    // デフォルトの中心値
    private var initialCenter: CGPoint = CGPoint(
        x: UIScreen.main.bounds.size.width / 2,
        y: UIScreen.main.bounds.size.height / 2
    )
    
    // ドラッグ開始時のViewがある位置を示す
    private var originalPoint: CGPoint = CGPoint.zero
    
    // 中心位置からの差分
    private var diffCenterX: CGFloat = 0.0
    private var diffCenterY: CGFloat = 0.0
    
    // 中心位置からのX軸方向へ何パーセント移動したか（移動割合）
    // NOTE: - 端部まで来た状態を1とする
    private var movingRateX: CGFloat = 0.0
    private var movingRateY: CGFloat = 0.0
    
    // size
    private let cardViewWidth: CGFloat = SwipableViewDefaultSetting.cardViewWidth
    private let cardViewHeight: CGFloat = SwipableViewDefaultSetting.cardViewWidth * SwipableViewDefaultSetting.cardViewAspectRatio

    // shadow
    private let shadowOffset: CGSize = SwipableViewDefaultSetting.shadowOffset
    private let shadowOpacity: CGFloat = SwipableViewDefaultSetting.shadowOpacity
    private let shadowBlur: CGFloat = SwipableViewDefaultSetting.shadowBlur

    // animation
    private let swipableXThreshold: CGFloat = SwipableViewDefaultSetting.swipableXThresholdLength
    private let lowerLimitViewScaling: CGFloat = SwipableViewDefaultSetting.lowerLimitViewScaling
    private let durationOfReturnOriginalScaling: TimeInterval = SwipableViewDefaultSetting.durationOfReturnOriginalScaling
    private let durationOfScalingWhenPositionUpdated: TimeInterval = SwipableViewDefaultSetting.durationOfScalingWhenPositionUpdated
    private let durationOfReturnOriginal: TimeInterval = SwipableViewDefaultSetting.durationOfReturnOriginal
    private let durationOfSwipeOut: TimeInterval = SwipableViewDefaultSetting.durationOfSwipeOut
    
    var delegate: SwipableViewSetDelegate?
    
    func setData(_ id: Int) {
        self.number = id
        
        self.setup()
        
        self.ageLabel.text = "27"
        self.nameLabel.text = "Arisa Bryant"
        self.nationLabel.text = "アメリカ"
        self.imageView.loadRandomImage(id: id + 50,
                                       width: Int(self.cardViewWidth),
                                       height: Int(self.cardViewHeight))
        self.setShadow()
        self.impressionView.configure(String(3.0))
        self.impressionView.delegate = self
    }
    
    /// 自身のViewを設定された最小値にスケーリングする
    func setMinimamScale() {
        let scale = self.lowerLimitViewScaling
        UIView.animate(withDuration: self.durationOfReturnOriginalScaling) {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    /// 指定の倍率に合わせて、画面を拡大縮小する
    /// - Parameter scaleToInitialSize: 初期画面に対しての拡大縮小倍率。0~1をとる。
    func scaleSizeBackView(_ scaleToInitialSize: CGFloat) {
        let scale = CGFloat(scaleToInitialSize)

        // 縮尺のセットアップ
        UIView.animate(withDuration: self.durationOfScalingWhenPositionUpdated) {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    /// 自身のUserInteractionを有効無効を切り替える
    func setUserInteraction(_ enable: Bool) {
        self.isUserInteractionEnabled = enable
    }
    
    private func setShadow() {
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = self.shadowOffset
        self.layer.shadowOpacity = Float(self.shadowOpacity)
        self.layer.shadowRadius = self.shadowBlur
    }
    
    private func setup() {
        self.setPreferences()
        self.setPanGestureRecognizer()
    }
}

extension SwipableView {
    
    private func setPreferences() {
        // frameのセットアップ
        self.frame = CGRect(
            origin: CGPoint.zero,
            size: CGSize(
                width: self.cardViewWidth,
                height: self.cardViewHeight
            )
        )
    }
    
    private func setPanGestureRecognizer() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.startDragging))
        self.addGestureRecognizer(panGestureRecognizer)
    }
    
    /// ドラッグ開始時の処理
    @objc private func startDragging(_ sender: UIPanGestureRecognizer) {
        
        // 中心地点からのX、Yの差分を更新する
        self.diffCenterX = sender.translation(in: self).x
        self.diffCenterY = sender.translation(in: self).y
        
        let tan = diffCenterY / abs(diffCenterX)
        
        switch sender.state {
            
        // ドラッグ開始時
        case .began:
            originalPoint = CGPoint(
                x: self.center.x - diffCenterX,
                y: self.center.y - diffCenterY
            )
            
            // Delegateに通知
            self.delegate?.beganDragging(self)
            
            print("beganCenterX:", originalPoint.x)
            print("beganCenterY:", originalPoint.y)
            
            break
            
        // ドラッグ中
        case .changed:
            let newPointX = originalPoint.x + diffCenterX
            let newPointY = originalPoint.y + diffCenterY
            
            // 新しい中心値をセット
            self.center = CGPoint(x: newPointX, y: newPointY)
            
            // Delegateに通知
            self.delegate?.swipableView(self, updatePosition: self.center)
            
            // TODO: 移動割合がこれであってるのかちょっとわかってない・・？
            self.movingRateX = min(diffCenterX / UIScreen.main.bounds.size.width, 1)
            self.movingRateY = min(diffCenterY / UIScreen.main.bounds.size.height, 1)
            
            // print("movingRateX:", movingRateX)
            // print("movingRateY:", movingRateY)
            
        case .ended, .cancelled:
            
            // ドラッグ終了時点での速度を算出
            let velocity = sender.velocity(in: self)
            
            // print("velocity:", velocity)
            
            // TODO: velocityが内側のベクトルだったら初期位置に戻るようにする
            
            let shouldMoveToLeft = self.diffCenterX < -self.swipableXThreshold
            let shouldMoveToRight = self.swipableXThreshold < self.diffCenterX
            
            if shouldMoveToLeft {
                self.moveOutOfScreen(tan, isLeft: true)
            }
            else if shouldMoveToRight {
                self.moveOutOfScreen(tan, isLeft: false)
            }
            else {
                self.returnToOriginalPosition()
                self.delegate?.returnToOriginalPosition(self)
            }
            
            // TODO: ドラッグ開始時の座標位置の変数を初期化する
            
            break
            
        default:
            break
        }
    }
    
    /// スワイプ中のカードを画面外に移動して削除する
    /// - Parameters:
    ///   - tan: x軸に対する仰角。第一象限、第二象限は正の値、第三象限、第四象限は負の値になる想定。
    ///   - isLeft: true → 左に動かす。 false → 右に動かす。
    private func moveOutOfScreen(_ tan: CGFloat, isLeft: Bool) {
        // 領域外に動かした後の場所を決める
        let absXPosition = UIScreen.main.bounds.size.width * 1.6
        let endCenterXPosition = isLeft ? -absXPosition : absXPosition
        let endCenterYPosition = (tan * absXPosition) + self.center.y
        let endCenterPosition = CGPoint(x: endCenterXPosition, y: endCenterYPosition)
        
        // print("moveOutOfScreen tan: \(tan)")
        // print("moveOutOfScreen currentCenter: \(self.center)")
        // print("moveOutOfScreen endCenterPosition: \(endCenterPosition)")
        
        UIView.animate(withDuration: self.durationOfSwipeOut, animations: {
            self.center = endCenterPosition
        }) { _ in
            self.removeFromSuperview()
            // completionが完了したらdelegateに通知
            if isLeft {
                self.delegate?.swipedLeftPosition(self)
            }
            else {
                self.delegate?.swipedRightPosition(self)
            }
        }
    }
    
    private func returnToOriginalPosition() {
        
        UIView.animate(withDuration: self.durationOfReturnOriginal) {
			// TODO: 左端を基準点にすると縮尺が変わってると中心からずれるのでcenterを基準にする
            self.frame.origin = .zero
        }
    }
}

extension SwipableView: ImpressionViewDelegate {
    
    func didTouchUpInsideImpressionButton() {
        // print("didTouchUpInsideImpressionButton")
    }
}
