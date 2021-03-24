//
//  DigitInputViewController.swift
//  UICatalog
//
//  Created by ichikawa on 2021/03/24.
//  Copyright © 2021 ichikawa. All rights reserved.
//

import UIKit

final class DigitInputViewController: UIViewController {
    
    @IBOutlet private weak var digitInputView: DigitInputView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.digitInputView.configure()
        self.digitInputView.delegate = self
    }
}

extension DigitInputViewController: DiditInputViewDelegate {

    func digitInputView(_ digitInputView: DigitInputView, didFinishInput text: String) {
        let alert = UIAlertController(
            title          : "認証コードが入力されました",
            message        : "認証コード: \(text)",
            preferredStyle : .alert
        )
        alert.addAction(UIAlertAction(
            title   : "OK",
            style   : .default,
            handler : { _ in
                self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
