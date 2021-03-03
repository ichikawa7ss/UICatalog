//
//  UserIconView.swift
//  UICatalog
//
//  Created by ichikawa on 2021/03/03.
//  Copyright © 2021 ichikawa. All rights reserved.
//

import UIKit

final class UserIconView: BaseView {
    
    @IBOutlet private weak var shadowHoverView: HoverView!
    @IBOutlet private weak var profileImageView: UIImageView!
    
    static let imageUnitWidth: CGFloat = 48
    static let bottomShadowUnitWidth: CGFloat = 40
    
    func configure(_ image: UIImage, isEnableTouchIcon: Bool = true) {
        self.profileImageView.image = image
        self.shadowHoverView.needAlphaAnimate = isEnableTouchIcon
        
        self.setCornerRadius()
        // セル再利用の度に影をセットしていると濃くなるため影が追加されていないときのみメソッドを実行する
        if self.shadowHoverView.subviews.count == 1 {
            self.layoutIfNeeded()
            self.profileImageView.setUserIconShadow()
        }
    }
    
    func configure(_ image: UIImage, isEnableTouchIcon: Bool = true, frame: CGRect) {
        // frameのセットアップ
        self.frame = frame
        self.configure(image, isEnableTouchIcon: isEnableTouchIcon)
    }
    
    private func setCornerRadius() {
        self.profileImageView.cornerRadius = self.frame.width / 2
    }
}

private extension UIImageView {
    
    func setUserIconShadow() {
        
        let imageUnitWidth: CGFloat = 48
        let bottomShadowUnitWidth: CGFloat = 40
        
        guard let superView = self.superview else {
            return
        }
        
        // アイコンに対して全体的に表示するシャドー
        let shadowView = UIView(frame: CGRect(origin: self.frame.origin, size: CGSize(width: self.frame.width, height: self.frame.height)))
        shadowView.layer.cornerRadius = self.frame.width / 2
        shadowView.backgroundColor = UIColor.white
        shadowView.layer.shadowColor = UIColor(hex: "3B4A60").cgColor
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowOpacity = 0.25
        shadowView.layer.shadowRadius = 4
        superView.insertSubview(shadowView, belowSubview: self)
        
        // アイコンの立体感を強調するために出すアイコン下部のシャドー
        // 単位長さに対する実際のviewの大きさの比率
        let viewRatio = self.frame.width / imageUnitWidth
        let shadowRatio = bottomShadowUnitWidth / imageUnitWidth
        let dx = ( imageUnitWidth - bottomShadowUnitWidth ) * viewRatio / 2
        let dy = ( imageUnitWidth - bottomShadowUnitWidth ) * viewRatio
        let bottomShadow = UIView(frame: CGRect(x: self.frame.origin.x + dx,
                                                y: self.frame.origin.y + dy,
                                                width: self.frame.width * shadowRatio,
                                                height: self.frame.height * shadowRatio))
        bottomShadow.layer.cornerRadius = self.frame.width * shadowRatio / 2
        bottomShadow.backgroundColor = UIColor.white
        bottomShadow.layer.shadowColor = UIColor(hex: "3B4A60").cgColor
        bottomShadow.layer.shadowOffset = CGSize(width: 0, height: 4)
        bottomShadow.layer.shadowOpacity = 0.4
        bottomShadow.layer.shadowRadius = 4
        superView.insertSubview(bottomShadow, belowSubview: self)
    }
}

