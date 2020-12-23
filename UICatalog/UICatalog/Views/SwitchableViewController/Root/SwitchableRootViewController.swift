//
//  SwitchableRootViewController.swift
//  UICatalog
//
//  Created by ichikawa on 2020/12/23.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

final class SwitchableRootViewController: UIViewController {

    // 1. OutletとSwitchButtonViewのdelegatewをセット
    @IBOutlet private weak var switchButtonView: SwitchButtonView! {
        willSet {
            newValue.delegate = self
        }
    }
    @IBOutlet private weak var containerView: UIView!
    
    var chiledViewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.switchButtonView.setup()
        self.setContentViewController(contentType: .home)
    }
}

extension SwitchableRootViewController: SwitchButtonViewDelegate {
    // 2. delegateメソッドからContainerViewに遷移先のVCをセットする関数を呼ぶ。
    func switchButtonView(_ switchButtonView: SwitchButtonView, didTapButton destinationContentType: ContentType) {
        self.setContentViewController(contentType: destinationContentType)
    }
}

// MARK: - setup
extension SwitchableRootViewController {
    // 3. UIView.transitionでコンテナ内に表示するViewの切り替え
    /// 指定されたコンテンツのVCにアニメーション遷移する
    /// - Parameter contentType: 表示するコンテンツ home/search
    private func setContentViewController(contentType: ContentType) {
        let vc = self.chiledViewControllers[contentType.rawValue]
        self.addChild(vc)
        let currentView = self.containerView.subviews.first ?? UIView()
        UIView.transition(
            from: currentView,
            to: vc.view,
            duration: 0.3,
            options: .transitionCrossDissolve,
            completion: { [weak self] _ in
                guard let `self` = self else { return }
                // addChildをしたあとはトランジションが完了したらdidMoveを呼ばなきゃいけない
                // 呼んでいない場合、追加したViewControllerのviewWillAppear:が動作しない場合がある
                vc.didMove(toParent: self)
                if let view = self.containerView.subviews.first {
                    view.translatesAutoresizingMaskIntoConstraints = false
                    // 制約をつけ直す
                    view.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
                    view.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor).isActive = true
                    view.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor).isActive = true
                    view.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
                }
        })
    }
}
