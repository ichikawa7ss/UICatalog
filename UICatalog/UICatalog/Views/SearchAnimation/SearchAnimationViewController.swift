//
//  SearchAnimationViewController.swift
//  UICatalog
//
//  Created by ichikawa on 2020/09/16.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

final class SearchAnimationViewController: UIViewController {
    
    @IBOutlet private weak var slideSearchHeaderView: SlideSearchHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.slideSearchHeaderView.delegate = self
    }
}

extension SearchAnimationViewController: SlideSearchHeaderViewDelegate {
    
    func willStartExpandAnimation(_ searchHeaderView: SlideSearchHeaderView) {
        print("willExpand")
    }
    
    func willStartShrinkAnimation(_ searchHeaderView: SlideSearchHeaderView) {
        print("willShrink")
    }
    
    func slideSearchHeaderView(_ searchHeaderView: SlideSearchHeaderView, didEnterTextField: UITextField) {
        print(didEnterTextField.text)
        print("didEnterButton")
    }
    
    func slideSearchHeaderView(_ searchHeaderView: SlideSearchHeaderView, didChangeCharacters: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) {
        print(didChangeCharacters.text)
        print("didChangeCharacters")
    }
}

