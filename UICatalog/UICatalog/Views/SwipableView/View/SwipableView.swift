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
    @IBOutlet private weak var favoriteView: UIView!

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
    
    // TODO: UIに関わる設定値を保持する
    
    private let swipableXThreshold: CGFloat = SwipableViewDefaultSetting.swipableXThresholdLength
    private let swipableThreshold: CGFloat = SwipableViewDefaultSetting.swipableYThresholdLength
    
    private let durationOfReturnOriginal: TimeInterval = SwipableViewDefaultSetting.durationOfReturnOriginal
    private let durationOfSwipeOut: TimeInterval = SwipableViewDefaultSetting.durationOfSwipeOut
    
    var delegate: SwipableViewSetDelegate?
    
    func setData(_ url: String) {
        self.setup()
        
        self.ageLabel.text = "27"
        self.nameLabel.text = "Arisa Bryant"
        self.nationLabel.text = "アメリカ"
        self.imageView.loadImage(url)
    }
    
    private func setup() {
    	
    }
}

extension SwipableView {

    private func setPanGestureRecognizer() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.startDragging))
        self.addGestureRecognizer(panGestureRecognizer)
    }
        
    /// ドラッグ開始時の処理
    @objc private func startDragging(_ sender: UIPanGestureRecognizer) {
    
        // 中心地点からのX、Yの差分を更新する
        self.diffCenterX = sender.translation(in: self).x
        self.diffCenterY = sender.translation(in: self).y
        
        switch sender.state {

        // ドラッグ開始時
        case .began:
            //
            originalPoint = CGPoint(
                x: self.center.x - diffCenterX,
                y: self.center.y - diffCenterY
            )
            
            // Delegateに通知
            self.delegate?.beganDragging(self)
            
            print("beganCenterX:", originalPoint.x)
            print("beganCenterY:", originalPoint.y)
            
            // TODO: 透明度や「LIKE」「NOPE」などの表示など、ドラッグに合わせたUIComponetsのプロパティを調整する
            
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
            
            print("movingRateX:", movingRateX)
            print("movingRateY:", movingRateY)
            
            // TODO: 移動割合に応じたUIの調整
            
        case .ended, .cancelled:
            
            // ドラッグ終了時点での速度を算出
            let velocity = sender.velocity(in: self)
            
            print("velocity:", velocity)
            
            let shouldMoveToLeft = self.diffCenterX < -self.swipableXThreshold
            let shouldMoveToRight = self.swipableXThreshold < self.diffCenterX
            
            if shouldMoveToLeft {
                self.moveOutOfScreen(velocity, isLeft: true)
                self.delegate?.swipedLeftPosition(self)
            }
            else if shouldMoveToRight {
                self.moveOutOfScreen(velocity, isLeft: false)
                self.delegate?.swipedRightPosition(self)
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
    
    private func moveOutOfScreen(_ velocity: CGPoint, isLeft: Bool) {
        // 領域外に動かした後の場所を決める
        let absXPosition = UIScreen.main.bounds.size.width * 1.6
        let endCenterXPosition = isLeft ? -absXPosition : absXPosition
        let endCenterYPosition = velocity.y // これってなんのvelocity?普通にsender経由じゃなくてもとれるの？？
        let endCenterPosition = CGPoint(x: endCenterXPosition, y: endCenterYPosition)
        
        UIView.animate(withDuration: self.durationOfSwipeOut, animations: {
            self.center = endCenterPosition
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
    private func returnToOriginalPosition() {

        UIView.animate(withDuration: self.durationOfReturnOriginal) {
            self.center = self.initialCenter
            
            // TOOD: -　移動時に透過度や縮尺や回転などを変えていたりしたら元に戻す
        }
    }
}