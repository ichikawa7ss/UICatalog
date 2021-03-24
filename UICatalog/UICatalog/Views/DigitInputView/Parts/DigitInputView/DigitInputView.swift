//
//  DigitInputView.swift
//  UICatalog
//
//  Created by ichikawa on 2021/03/24.
//  Copyright © 2021 ichikawa. All rights reserved.
//

import UIKit

final class DigitInputView: BaseView {

    @IBOutlet private var digitInputTextFields: [DigitInputTextField]!
    
    func configure() {
        self.digitInputTextFields.forEach { $0.configure() }
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
    
    // プロパティの設定
    func configure() {
        self.textColor = .blue
        self.font = UIFont(name: "HiraginoSans-W6", size: 48)!
        self.textAlignment = .center
    }
}
