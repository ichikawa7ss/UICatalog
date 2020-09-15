//
//  UIViewController+.swift
//  UICatalog
//
//  Created by ichikawa on 2020/09/16.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

extension UIViewController: StoryBoardInstantiate {}

protocol StoryBoardInstantiate {
    static func instantiate() -> Self
}

extension StoryBoardInstantiate where Self: UIViewController {

    static func instantiate() -> Self {
        let bundle = Bundle(for: self.self)
        let name = String(describing: self.self)

        guard let vc = UIStoryboard(name: name, bundle: bundle).instantiateInitialViewController() as? Self else {
            fatalError("UIViewController.instantiate() failed: \(name)")
        }

        return vc
    }
}
