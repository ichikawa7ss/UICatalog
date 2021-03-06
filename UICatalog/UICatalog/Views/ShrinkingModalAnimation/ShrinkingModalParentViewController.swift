//
//  ShrinkingModalParentViewController.swift
//  UICatalog
//
//  Created by ichikawa on 2021/03/31.
//  Copyright © 2021 ichikawa. All rights reserved.
//

import UIKit

final class ShrinkingModalParentViewController: UIViewController {
    
    @IBOutlet private weak var toDetailButton: UIButton!
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
    }
    
    @IBAction func didTapDetailButton(_ sender: Any) {
        self.makeBlurView()
        self.presentChild()
    }
    @IBAction func didTapBackMenuButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func removeBlurView() {
        guard let blurView = self.view.subviews[1] as? UIVisualEffectView else {
            print("blurViewが取れていない")
            return
        }
        UIView.animate(withDuration: 0.2, delay: 0.0) {
            blurView.alpha = 0.0
        } completion: { finished in
            if finished {
                blurView.removeFromSuperview()
            }
        }
    }
    
    private func makeBlurView() {
        let blurEffect = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = self.view.frame
        self.view.insertSubview(visualEffectView, belowSubview: self.toDetailButton)
    }
    
    private func presentChild() {
        let vc = ShrinkingModalChildViewController.instantiate()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
}
