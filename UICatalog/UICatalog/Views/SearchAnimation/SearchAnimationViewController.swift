//
//  SearchAnimationViewController.swift
//  UICatalog
//
//  Created by ichikawa on 2020/09/16.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

final class SearchAnimationViewController: UIViewController {
    
    @IBOutlet private weak var searchButton: UIView! {
        willSet {
            let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self,  action: #selector(SearchAnimationViewController.tapped(_:)))
            newValue.addGestureRecognizer(tapGesture)
        }
    }
    @IBOutlet private weak var searchButtonWidthConstraints: NSLayoutConstraint!
    @IBOutlet private weak var searchButtonTrailingConstraints: NSLayoutConstraint!
    @IBOutlet private weak var textFiledWidthConstraints: NSLayoutConstraint!
    @IBOutlet private weak var textFiledTrailingConstraints: NSLayoutConstraint!
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var headerView: UIView!
    
    
    let searchButtonWidth = 32.0
    var searchButtonAnimationStyle: ButtonAnimationStyle = .expand
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        updateSearchButtonLayout(style: self.searchButtonAnimationStyle)
        UIView.animate(withDuration: 0.3, delay: 0.0, animations: {
            self.view.layoutIfNeeded()
        })
    }
}

extension SearchAnimationViewController {
    
    private func updateSearchButtonLayout(style: ButtonAnimationStyle) {
        switch style {
        case .expand:
            self.textFiledWidthConstraints.isActive = true
            self.textFiledTrailingConstraints.isActive = true
            self.searchButtonWidthConstraints.isActive = false
            self.searchButtonTrailingConstraints.isActive = false
        case .shrink:
            self.textFiledWidthConstraints.isActive = false
            self.textFiledTrailingConstraints.isActive = false
            self.searchButtonWidthConstraints.isActive = true
            self.searchButtonTrailingConstraints.isActive = true
        }
        self.searchButtonAnimationStyle = searchButtonAnimationStyle.getOpposite()
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
