//
//  ShrinkingModalParentViewController.swift
//  UICatalog
//
//  Created by ichikawa on 2021/03/31.
//  Copyright © 2021 ichikawa. All rights reserved.
//

import UIKit

final class ShrinkingModalParentViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapDetailButton(_ sender: Any) {
        let vc = ShrinkingModalChildViewController.instantiate()
        vc.modalPresentationStyle = .overCurrentContext
        // TODO: 間にBlurViewを挟む
        // vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
}
