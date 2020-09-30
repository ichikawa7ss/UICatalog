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
    @IBOutlet private weak var profileView: UIImageView!
    @IBOutlet weak var backMenuButton: UIButton! {
        willSet {
            newValue.setImage(UIImage(systemName: "arrowshape.turn.up.left.circle.fill"), for: .normal)
            newValue.tintColor = .black
            newValue.contentVerticalAlignment = .fill
            newValue.contentHorizontalAlignment = .fill
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.slideSearchHeaderView.delegate = self
    }
    
    @IBAction func tapBackToMenuButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SearchAnimationViewController: SlideSearchHeaderViewDelegate {
    
    func willStartExpandAnimation(_ searchHeaderView: SlideSearchHeaderView) {
        self.profileView.image = UIImage(named: "SearchingView")
        self.backMenuButton.isHidden = true
    }
    
    func willStartShrinkAnimation(_ searchHeaderView: SlideSearchHeaderView) {
        self.profileView.image = UIImage(named: "ProfileView")
        self.backMenuButton.isHidden = false
    }
    
    func slideSearchHeaderView(_ searchHeaderView: SlideSearchHeaderView, didEnterTextField: UITextField) {
        // NOP
    }
    
    func slideSearchHeaderView(_ searchHeaderView: SlideSearchHeaderView, didChangeCharacters: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) {
        // NOP
    }
}

