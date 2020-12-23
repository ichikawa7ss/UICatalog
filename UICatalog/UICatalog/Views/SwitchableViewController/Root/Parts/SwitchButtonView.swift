//
//  SwitchButtonView.swift
//  UICatalog
//
//  Created by ichikawa on 2020/12/23.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

final class SwitchButtonView: UIView {

    @IBOutlet private weak var toSearchButtonView: UIView! {
        didSet {
            // 2. 各ボタンとなるViewに`UITapGestureRecogniger`をaddする。
            toSearchButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapToSearchButtonView)))
        }
    }
    @IBOutlet private weak var toHomeButtonView: UIView! {
        didSet {
            // 2. 各ボタンとなるViewに`UITapGestureRecogniger`をaddする。
            toHomeButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapToHomeButtonView)))
        }
    }
    
    var delegate: SwitchButtonViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }

    private func configure() {
        let nib = UINib(nibName: "SwitchButtonView", bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        addSubview(view)
    }
    
    func setup() {
        // 回転したときに正対して見えるように予め画像を反転させておく
        self.toHomeButtonView.transform = CGAffineTransform(rotationAngle: .pi)
    }
}

// MARK: - Event
extension SwitchButtonView {
    @objc
    private func tapToSearchButtonView() {
        // 3. Viewの回転
        self.rotate(to: .search)
        // 4. delegateでRootViewControllerにタップイベントを伝播
        self.delegate?.switchButtonView(self, didTapButton: .search)
    }
    
    @objc
    private func tapToHomeButtonView() {
        // 3. Viewの回転
        self.rotate(to: .home)
        // 4. delegateでRootViewControllerにタップイベントを伝播
        self.delegate?.switchButtonView(self, didTapButton: .home)
    }
    
    /// SwitchButtonViewの回転処理
    /// - Parameter type: タップされたボタンのタイプ。タップするボタンのタイプ似合わせて回転方向を変える。
    private func rotate(to type: ContentType) {
        UIView.animate(withDuration: 0.3) {
            switch type {
            case .search:
                // 検索画面への遷移だったら時計回りで回転
                self.transform = CGAffineTransform(rotationAngle: -.pi * 0.999) // 反転時は時計回りにしたいので半回転しきらないようにしておく
            case .home:
                // ホーム画面への遷移だったら反時計回りで戻す
                self.transform = .identity
            }
        }
    }
}

protocol SwitchButtonViewDelegate {
    func switchButtonView(_ switchButtonView: SwitchButtonView, didTapButton destinationContentType: ContentType)
}

/// スイッチングで表示するコンテンツのタイプ
enum ContentType: Int {
    case home
    case search
}
