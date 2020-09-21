//
//  SlideSearchHeaderView.swift
//  UICatalog
//
//  Created by ichikawa on 2020/09/21.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

protocol SlideSearchHeaderViewDelegate: AnyObject {
    func willStartExpandAnimation()
    func willStartShrinkAnimation()
    func didEnterTextField()
    func didChangeCharacters()
}

extension SlideSearchHeaderViewDelegate {
    func willExpandStartAnimation() {}
    func willStartShrinkAnimation() {}
    func didEnterTextField() {}
    func didChangeCharacters() {}
}

class SlideSearchHeaderView: UIView {

    @IBOutlet private weak var searchButtonView: UIView!
    @IBOutlet private weak var searchButtonGestureRecognizer: UIGestureRecognizer!
    @IBOutlet private weak var searchButtonWidthConstraints: NSLayoutConstraint!
    @IBOutlet private weak var searchButtonTrailingConstraints: NSLayoutConstraint!
    @IBOutlet private weak var textFiledLeadingConstraints: NSLayoutConstraint!
    @IBOutlet private weak var textFiledTrailingConstraints: NSLayoutConstraint!
    @IBOutlet private weak var headerTitleLabel: UILabel!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var separator: UIView!
    
    weak var delegate: SlideSearchHeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        // NOP
    }
}

// MARK: - Action
extension SlideSearchHeaderView {
    
    @IBAction func tapSearchButton(_ sender: UITapGestureRecognizer) {
        self.delegate?.willStartExpandAnimation()
        self.updateSearchStatus(style: .expand)
    }
    
    @IBAction func tapCancelButton(_ sender: UIButton) {
        self.delegate?.willStartShrinkAnimation()
        self.updateSearchStatus(style: .shrink)
    }
    
    private func updateSearchStatus(style: ButtonAnimationStyle) {
        presetupSearchComponentPreference(style: style)
        UIView.animate(withDuration: 0.2, delay: 0.0, animations: {
            self.layoutIfNeeded()
        }, completion: { _ in
            self.didCompleteAnimation(style: style)
            self.layoutIfNeeded() // todo
        })
    }
}

// MARK: - Set Preference
extension SlideSearchHeaderView {
    
    /// 検索アニメーションのコンポーネント設定を前もって設定
    private func presetupSearchComponentPreference(style: ButtonAnimationStyle) {
        self.presetupSearchHeaderPreference(style: style)
    }
    
    /// アニメーション完了後に設定する処理
    private func didCompleteAnimation(style: ButtonAnimationStyle) {
        switch style {
        case .expand:
            self.addSearchTextField()
        case .shrink:
            break
        }
    }
    
    private func presetupSearchHeaderPreference(style: ButtonAnimationStyle) {
        let willSearch = .expand == style
        
        // テキストフィールドの制約切り替え
        self.textFiledLeadingConstraints.priority = willSearch ? UILayoutPriority(rawValue: 750) : UILayoutPriority(rawValue: 250)
        self.textFiledTrailingConstraints.priority = willSearch ? UILayoutPriority(rawValue: 750) : UILayoutPriority(rawValue: 250)
        self.searchButtonWidthConstraints.priority = willSearch ? UILayoutPriority(rawValue: 250) : UILayoutPriority(rawValue: 750)
        self.searchButtonTrailingConstraints.priority = willSearch ? UILayoutPriority(rawValue: 250) : UILayoutPriority(rawValue: 750)

        // 各パーツのUI設定
        self.headerTitleLabel.isHidden = willSearch
        self.cancelButton.isHidden = !willSearch
        self.separator.isHidden = !willSearch
        
        // SearchButtonGestureRecognizer
        self.searchButtonGestureRecognizer.isEnabled = !willSearch
        
        if !willSearch {
            // テキストフィールドを削除
            self.searchButtonView.subviews.filter { $0 is UITextField }.first!.removeFromSuperview()
        }
    }
    
    private func addSearchTextField() {
        // テキストフィールドの設定
        let frame = CGRect(x: 32, y: 8, width: 300, height: 16)
        let textField = UITextField(frame: frame)
        self.searchButtonView.addSubview(textField)
        // テキストフィールドにフォーカス
        textField.becomeFirstResponder()
        textField.placeholder = "Search My Animation"
        textField.tintColor = .gray
        
        textField.delegate = self
    }
}

extension SlideSearchHeaderView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.updateSearchStatus(style: .shrink)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
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
