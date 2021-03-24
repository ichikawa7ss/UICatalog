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
    }
}
