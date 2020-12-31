//
//  ImpressionView.swift
//  UICatalog
//
//  Created by ichikawa on 2020/12/29.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

protocol ImpressionViewDelegate: AnyObject {
    func didTouchUpInsideImpressionButton()
}

class ImpressionView: BaseView {
    
    @IBOutlet private weak var impressionButton: HoverView!
    @IBOutlet private weak var scoreLabel: UILabel!
        
    weak var delegate: ImpressionViewDelegate?
    
    func configure(_ score: String) {
        self.impressionButton.delegate = self
        self.scoreLabel.text = score
    }
}

extension ImpressionView: HoverViewDelegate {
    
    func didTouchUpInside() {
        self.delegate?.didTouchUpInsideImpressionButton()
    }
}
