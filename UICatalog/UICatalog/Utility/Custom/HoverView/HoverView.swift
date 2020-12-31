//
//  HoverView.swift
//  MangaMee
//
//  Created by masaki hasegawa on 2018/06/18.
//  Copyright © 2018年 andfactory. All rights reserved.
//

import UIKit

protocol HoverViewDelegate: AnyObject {
    func didTouchDown()
    func didTouchCancel()
    func didTouchUpInside()
    func didTouchUpInside(sender: HoverView)
}

extension HoverViewDelegate {
    func didTouchDown() {}
    func didTouchCancel() {}
    func didTouchUpInside() {}
    func didTouchUpInside(sender: HoverView) {}
}

final class HoverView: UIView {
    
    // defaultはalphaもscaleもアニメーション対象
    @IBInspectable var needAlphaAnimate     : Bool = true
    @IBInspectable var needScaleAnimate     : Bool = true
    @IBInspectable var needHighlightAnimate : Bool = false
    
    private var touchDown = false
    var shrinkScale: CGFloat = 0.9
    var expansionScale: CGFloat = 1.3
    var normalBackgroundColor: UIColor = .white {
        willSet {
            self.backgroundColor = newValue
        }
    }
    weak var delegate: HoverViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.isExclusiveTouch = true
    }
}

// MARK: - touch
extension HoverView {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchDown = true
        self.startForwardAnimate()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !self.touchDown {
            return
        }
        if let touch = touches.first {
            let point = convert(touch.location(in: self), to: self)
            if point.x < 0 || point.x > self.bounds.size.width || point.y < 0 || point.y > self.bounds.size.height {
                self.endForwardAnimate()
                return
            }
            else {
                self.startBackAnimate()
            }
            self.touchDown = false
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !self.touchDown {
            return
        }
        
        self.endForwardAnimate()
        self.touchDown = false
    }
}

// MARK: - animation
extension HoverView {
    
    private func startForwardAnimate() {
        self.delegate?.didTouchDown()
        
        UIView.animate(
            withDuration: 0.1,
            animations: { [weak self] in
                guard let self = self else { return }
                if self.needAlphaAnimate {
                    self.alpha = 0.6
                }
                if self.needScaleAnimate {
                    self.transform = self.transform.scaledBy(x: self.shrinkScale, y: self.shrinkScale)
                }
                if self.needHighlightAnimate {
                    self.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.831372549, blue: 0.831372549, alpha: 1)
                }
        })
    }
    
    private func endForwardAnimate() {
        self.delegate?.didTouchCancel()
        
        UIView.animate(
            withDuration: 0.1,
            animations: { [weak self] in
                guard let self = self else { return }
                if self.needAlphaAnimate {
                    self.alpha = 1.0
                }
                if self.needScaleAnimate {
                    self.transform = .identity
                }
                if self.needHighlightAnimate {
                    self.backgroundColor = self.normalBackgroundColor
                }
        })
    }
    
    private func startBackAnimate() {
        self.delegate?.didTouchUpInside()
        self.delegate?.didTouchUpInside(sender: self)
        
        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            options: .curveEaseIn,
            animations: { [weak self] in
                guard let self = self else { return }
                if self.needAlphaAnimate {
                    self.alpha     = 1.0
                }
                if self.needScaleAnimate {
                    self.transform = self.transform.scaledBy(x: self.expansionScale, y: self.expansionScale)
                }
                if self.needHighlightAnimate {
                    self.backgroundColor = self.normalBackgroundColor
                }
        },  completion: { _ in
            UIView.animate(
                withDuration: 0.2,
                delay: 0,
                options: .curveEaseInOut,
                animations: { [weak self] in
                    guard let self = self else { return }
                    if self.needScaleAnimate {
                        self.transform = .identity
                    }
            },  completion: nil)
        })
    }
}
