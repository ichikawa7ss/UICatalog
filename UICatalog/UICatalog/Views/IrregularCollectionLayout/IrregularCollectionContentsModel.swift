//
//  IrregularCollectionContentsModel.swift
//  UICatalog
//
//  Created by ichikawa on 2020/11/04.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import Foundation

enum IrregularCollectionContentsModelGenarator {
    
    static func generate() -> [ContentsType] {
        return [
            .small, .small, .small, .small, .large,
            .small, .small, .small, .small, .small, .small, .small, .small, .small, .small, .small, .small, .large,
            .small, .small, .small, .small, .small, .small, .small, .large,
            .small, .small, .small, .small, .small, .small, .small, .small, .small, .large,
            .small, .small, .small, .small, .small, .small, .small, .small, .small, .small, .small, .small, .small, .small, .small, .small,  .large,
            .small, .small, .small, .small,
        ]
    }
}

enum ContentsType {
    case small
    case large
}
