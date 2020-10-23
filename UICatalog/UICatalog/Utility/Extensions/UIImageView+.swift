//
//  UIImageView+.swift
//  UICatalog
//
//  Created by ichikawa on 2020/10/15.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit
import Nuke

extension UIImageView {
    
    /// フリー画像を提供しているLorem PicsumからIDとサイズを指定して画像をセットする
    /// - Parameters:
    ///   - id: 指定する画像のID
    ///   - width: 画像横サイズ
    ///   - height: 画像縦サイズ
    func loadRandomImage(id: Int, width: Int, height: Int) {
        let urlString = "https://picsum.photos/id/\(id)/\(width)/\(height)"
        self.loadImage(urlString)
    }
    
    /// URLの文字列から画像を読み込んでセットする
    /// - Parameter urlString: URL文字列
    func loadImage(_ urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return
        }
        let options = ImageLoadingOptions(
            //placeholder: UIImage(named: "placeholder"),
            transition: .fadeIn(duration: 0.33)
        )
        Nuke.loadImage(with: url, options: options, into: self, completion: { response in
            switch response {
            case .success:
                break
            case .failure(let error):
                print(error)
            }
        })
    }
}
