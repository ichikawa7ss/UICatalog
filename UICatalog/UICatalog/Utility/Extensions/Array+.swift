//
//  Array+.swift
//  UICatalog
//
//  Created by ichikawa on 2020/11/25.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import Foundation

extension Array {

    /// 範囲を超えてもクラッシュしない
    public subscript (safe index: Int) -> Element? {
        return self.indices ~= index ? self[index] : nil
    }

    /// 範囲を超えてもクラッシュしない
    public subscript (reverse index: Int) -> Element {
        return self[self.count - index - 1]
    }
    
}

extension Array {
    func twoPair() -> [(Element, Element?)] {
        var copy: [Element?] = self
        copy.append(nil)

        return self.enumerated()
            .map { ($0.element, copy[$0.offset + 1]) }
    }
    
    func threePair() -> [(Element, Element?, Element?)] {
        var copy: [Element?] = self
        copy.append(nil)
        copy.append(nil)

        return self.enumerated()
            .map { ($0.element, copy[$0.offset + 1], copy[$0.offset + 2]) }
    }
}
