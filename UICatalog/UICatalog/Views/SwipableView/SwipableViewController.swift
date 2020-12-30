//
//  SwipableViewController.swift
//  UICatalog
//
//  Created by ichikawa on 2020/12/28.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

final class SwipableViewController: UIViewController {

    private var imgURLs = [String](repeating: "", count: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
}

// MARK: setup
extension SwipableViewController {
    
    private func setup() {
        let navigationBarHeight = self.navigationController?.navigationBar.frame.size.height ?? 0.0
        let centerY = (self.view.frame.height - navigationBarHeight) / 2.0 + navigationBarHeight
        let baseView = UIView()
        baseView.frame = CGRect(x: 50, y: 50, width: 344, height: 530)
        baseView.center = CGPoint(x: self.view.center.x , y: centerY)
        self.view.addSubview(baseView)
        
        self.imgURLs.enumerated().map { args in
            let swipableCardView = SwipableView()
            swipableCardView.delegate = self
            swipableCardView.setData(args.offset)
            
            baseView.addSubview(swipableCardView)
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
