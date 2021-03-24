//
//  DigitInputView.swift
//  UICatalog
//
//  Created by ichikawa on 2021/03/24.
//  Copyright © 2021 ichikawa. All rights reserved.
//

import UIKit

protocol DiditInputViewDelegate: AnyObject {
    func digitInputView(_ digitInputView: DigitInputView, didFinishInput text: String)
}

final class DigitInputView: BaseView {

    @IBOutlet private var digitInputTextFields: [DigitInputTextField]!
    weak var delegate: DiditInputViewDelegate?
    
    func configure() {
        self.digitInputTextFields.forEach { textField in
            textField.configure()
            textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        }
        _ = self.digitInputTextFields.filter { $0.tag == 0 }.map { $0.becomeFirstResponder() } // 最初のテキストにフォーカスしておく
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.tag != 5 {
            // 最終タグ以外
            _ = self.digitInputTextFields.filter { $0.tag == textField.tag + 1 }.map { $0.becomeFirstResponder() }
        }
        else {
            // 最終タグはdelegateで親のViewControllerに通知
            guard self.digitInputTextFields.allSatisfy({ $0.isInputed }) else {
                return
            }
            self.delegate?.digitInputView(self, didFinishInput: self.digitInputTextFields.compactMap { $0.text }.joined())
        }
    }
}

final class DigitInputTextField: UITextField {
    
    // 入力カーソル非表示
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    // 範囲選択カーソル非表示
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        return []
    }

    // コピー・ペースト・選択等のメニュー非表示
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
    var isInputed: Bool {
        return !(self.text?.isEmpty ?? true)
    }
    
    // プロパティの設定
    func configure() {
        self.textColor = .blue
        self.font = UIFont(name: "HiraginoSans-W6", size: 48)!
        self.textAlignment = .center
        self.keyboardType = .numberPad
    }
}
