//
//  ShrinkingModalChlildViewController.swift
//  UICatalog
//
//  Created by ichikawa on 2021/03/31.
//  Copyright © 2021 ichikawa. All rights reserved.
//

import UIKit

final class ShrinkingModalChildViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView! {
        willSet {
            newValue.register(ShrinkingCell.self)
            newValue.contentInset.top = -20
        }
    }
    
    private var shrinkableGestureRecognizer: UIPanGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setGesture()
    }
    
    @IBAction func didTapCloseButton(_ sender: Any) {
        self.dismissWithRemoveParentBlurView()
    }
    
    private func setGesture() {
        self.shrinkableGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.startDragging))
        self.shrinkableGestureRecognizer?.delegate = self
        self.tableView.addGestureRecognizer(shrinkableGestureRecognizer!)
        self.tableView.panGestureRecognizer.require(toFail: self.shrinkableGestureRecognizer!)
    }
    
    @objc
    func startDragging(_ sender: UIPanGestureRecognizer) {
        // 中心地点からのYの差分を更新する
        let diff = sender.translation(in: self.view).y
        
        switch sender.state {
            
        // ドラッグ開始時
        case .began:
            break
        // ドラッグ中
		// スクロール位置に応じてtransform
        case .changed:
            let maxShrinkingScale = CGFloat(0.8) // 画面いっぱいに表示した状態からどこまで縮小を許すか
            let swipableThresholdDiffY = CGFloat(80) // swipeできる限界（どこまでいったらdismissするか）
            let scalingRatio = max(((swipableThresholdDiffY - abs(diff)) / swipableThresholdDiffY) * (1 - maxShrinkingScale) + maxShrinkingScale, maxShrinkingScale)
            let minimumCornerRadius = CGFloat(20) // swipeできる限界（どこまでいったらdismissするか）
            let conrerRadiusRatio = (1 - scalingRatio) * (5 * minimumCornerRadius)
            if diff > swipableThresholdDiffY {
                // 閾値を超えたらdismissする
                self.dismissWithRemoveParentBlurView()
            }
            else if diff != -48.0  {
                // diffに合わせてself.viewをtransformする
                UIView.animate(withDuration: 0.01) {
                    print(conrerRadiusRatio)
                    self.view.cornerRadius = conrerRadiusRatio
                    self.tableView.cornerRadius = conrerRadiusRatio
                    self.view.transform = CGAffineTransform(scaleX: scalingRatio, y: scalingRatio)
                }
            }
        case .ended, .cancelled:
            UIView.animate(withDuration: 0.01) {
                self.view.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        default:
            break
        }
    }
    
    private func dismissWithRemoveParentBlurView() {
        guard let navVC = self.presentingViewController as? UINavigationController else {
            print("navVCが取れていない")
            return
        }
        guard let parent = navVC.viewControllers[safe: navVC.viewControllers.count - 1] as? ShrinkingModalParentViewController else {
            print("parentが取れていない")
            return
        }
        self.dismiss(animated: true) {
            parent.removeBlurView()
        }
    }
}

extension ShrinkingModalChildViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let panGesture = gestureRecognizer as? UIPanGestureRecognizer else {
                return false
        }
        let translation = panGesture.translation(in: self.view)
        if translation.y > 0 && self.tableView.contentOffset.y <= 0 {
            return true
        }
        else {
            return false
        }
    }
}

extension ShrinkingModalChildViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.shrinkingCell(tableView.dequeueReusableCell(for: indexPath))
        return cell
    }
    
    private func shrinkingCell(_ cell: ShrinkingCell) -> ShrinkingCell {
        cell.configure()
        return cell
    }
}
