//
//  UIView+.swift
//  UICatalog
//
//  Created by ichikawa on 2020/09/16.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

// MARK: - nib
extension UIView {

    static var nib: UINib {
        let bundle = Bundle(for: self.self)
        return UINib(nibName: self.className, bundle: bundle)
    }

    var nib: UINib {
        return type(of: self).nib
    }
}

// MARK: - class name
extension UIView {

    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}

extension UIView {
 
    // 枠線の色
    @IBInspectable var borderColor: UIColor? {
        get {
            return layer.borderColor.map { UIColor(cgColor: $0) }
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    // 枠線のWidth
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            // 0.5などの小数第一位が5の値が入った場合、レンダリングの倍率によって描画される線の太さにブレが出る
            // https://qiita.com/koogawa/items/c91f53cc4cb8a59978b4
            let scale = UIScreen.main.scale
            layer.borderWidth = round( newValue * scale ) / scale
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    func matchParent(_ parent: UIView, isEnableSafe: Bool = false, padding: UIEdgeInsets = .zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if isEnableSafe, #available(iOS 11.0, *) {
            self.topAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.topAnchor, constant: padding.top).isActive = true
            self.leadingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.leadingAnchor, constant: padding.left).isActive = true
            self.trailingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.trailingAnchor, constant: padding.right).isActive = true
            self.bottomAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.bottomAnchor, constant: padding.bottom).isActive = true
        }
        else {
            self.topAnchor.constraint(equalTo: parent.topAnchor, constant: padding.top).isActive = true
            self.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: padding.left).isActive = true
            self.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: padding.right).isActive = true
            self.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: padding.bottom).isActive = true
        }
    }
}
