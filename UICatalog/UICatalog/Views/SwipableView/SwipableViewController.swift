//
//  SwipableViewController.swift
//  UICatalog
//
//  Created by ichikawa on 2020/12/28.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

final class SwipableViewController: UIViewController {

    private var imgURLs = [String](repeating: "", count: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
}

// MARK: setup
extension SwipableViewController {
    
    private func setup() {
        self.imgURLs.map { url in
            let swipableCardView = SwipableView()
            swipableCardView.delegate = self
            swipableCardView.setData(url)
            
            self.view.addSubview(swipableCardView)
        }
    }
}

extension SwipableViewController: SwipableViewSetDelegate {
    func beganDragging(_ swipableView: SwipableView) {
        print("beganDragging")
    }
    
    func swipableView(_ swipableView: SwipableView, updatePosition: CGPoint) {
        print("updatePosition \(updatePosition)")
    }
    
    func swipedLeftPosition(_ swipableView: SwipableView) {
        print("swipedLeftPosition")
    }
    
    func swipedRightPosition(_ swipableView: SwipableView) {
        print("swipedRightPosition")
    }
    
    func returnToOriginalPosition(_ swipableView: SwipableView) {
        print("returnToOriginalPosition")
    }
    
    
}
