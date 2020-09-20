//
//  SearchAnimationViewController.swift
//  UICatalog
//
//  Created by ichikawa on 2020/09/16.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

final class SearchAnimationViewController: UIViewController {
    
    @IBOutlet private weak var searchButton: UIView!
    @IBOutlet private weak var searchButtonGestureRecognizer: UIGestureRecognizer!
    @IBOutlet private weak var searchButtonWidthConstraints: NSLayoutConstraint!
    @IBOutlet private weak var searchButtonTrailingConstraints: NSLayoutConstraint!
    @IBOutlet private weak var textFiledWidthConstraints: NSLayoutConstraint!
    @IBOutlet private weak var textFiledTrailingConstraints: NSLayoutConstraint!
    @IBOutlet private weak var searchAnimationLabel: UILabel!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension SearchAnimationViewController {
    
    @IBAction func tapSearchButton(_ sender: UITapGestureRecognizer) {
        self.updateSearchStatus(style: .expand)
    }
    
    @IBAction func tapCancelButton(_ sender: UIButton) {
        self.updateSearchStatus(style: .shrink)
    }
    
    private func updateSearchStatus(style: ButtonAnimationStyle) {
        preupdateSearchComponentLayout(style: style)
        UIView.animate(withDuration: 0.2, delay: 0.0, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.didCompleteAnimation(style: style)
            self.view.layoutIfNeeded()

        })
    }
}

extension SearchAnimationViewController {
    
    /// 検索アニメーションのコンポーネント設定を前もって設定
    private func preupdateSearchComponentLayout(style: ButtonAnimationStyle) {
        switch style {
        case .expand:
            // テキストフィールドの制約切り替え
            self.textFiledWidthConstraints.isActive = true
            self.textFiledTrailingConstraints.isActive = true
            self.searchButtonWidthConstraints.isActive = false
            self.searchButtonTrailingConstraints.isActive = false

            // 各パーツのUI設定
            self.searchAnimationLabel.isHidden = true // "Search Animation"ラベル  （命名を修正）
            self.cancelButton.isHidden = false
            
            // SearchButtonGestureRecognizer
            self.searchButtonGestureRecognizer.isEnabled = false

        case .shrink:
            // テキストフィールドの制約切り替え
            self.textFiledWidthConstraints.isActive = false
            self.textFiledTrailingConstraints.isActive = false
            self.searchButtonWidthConstraints.isActive = true
            self.searchButtonTrailingConstraints.isActive = true
            
            // 各パーツのUI設定
            self.searchAnimationLabel.isHidden = false
            self.cancelButton.isHidden = true
            
            // テキストフィールドを削除
            self.searchButton.subviews.filter { $0 is UITextField }.first!.removeFromSuperview()
            
            // SearchButtonGestureRecognizer
            self.searchButtonGestureRecognizer.isEnabled = true
        }
    }
    
    /// アニメーション完了後に設定する処理
    private func didCompleteAnimation(style: ButtonAnimationStyle) {
        switch style {
        case .expand:
            // テキストフィールドの設定
            let frame = CGRect(x: 32, y: 0, width: 300, height: 32)
            let textField = UITextField(frame: frame)
            self.searchButton.addSubview(textField)
            // テキストフィールドにフォーカス
            textField.becomeFirstResponder()
            textField.placeholder = "Search My Animation"
            textField.tintColor = .gray
        case .shrink:
            break
        }
    }
}

enum ButtonAnimationStyle {
    
    case expand
    case shrink
    
    func getOpposite() -> ButtonAnimationStyle {
        switch self {
        case .expand:
            return .shrink
        case .shrink:
            return .expand
        }
    }
}
