//
//  SmoothSelectableTableView.swift
//  UICatalog
//
//  Created by ichikawa on 2021/08/09.
//  Copyright © 2021 ichikawa. All rights reserved.
//

import UIKit

protocol SmoothSelectableTableViewDelegate: AnyObject {
    func smoothSelectableTableView(_ tableView: SmoothSelectableTableView, didUpdateLongPressState state: SmoothSelectalbeTableViewState)
}

enum SmoothSelectalbeTableViewState {
    case began(IndexPath)
    case changed([IndexPath])
    case ended(IndexPath)
}

final class SmoothSelectableTableView: UITableView, UIGestureRecognizerDelegate {

    private var longPressRecognizer: UILongPressGestureRecognizer?
    private var selectedIndexPaths = [IndexPath]()
    private weak var smoothSelectionDelegate: SmoothSelectableTableViewDelegate?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupLongPress(_ delegate: SmoothSelectableTableViewDelegate?) {
        self.smoothSelectionDelegate = delegate
        self.setupLongPressGestureRecognizer()
    }

    private func setupLongPressGestureRecognizer(allowableMovement: CGFloat = 15, minimumPressDuration: TimeInterval = 0.2) {
        self.longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longTapped))
        self.longPressRecognizer?.allowableMovement = allowableMovement
        self.longPressRecognizer?.minimumPressDuration = minimumPressDuration
        self.addGestureRecognizer(self.longPressRecognizer!)
        self.longPressRecognizer!.delegate = self
    }

    @objc
    func longTapped(recognizer: UILongPressGestureRecognizer) {
        let currentPoint = self.longPressRecognizer!.location(in: self)
        guard let currentIndexPath = self.indexPathForRow(at: currentPoint) else {
            return
        }
        switch recognizer.state {
        case .began:
            self.selectedIndexPaths = [currentIndexPath]
            self.smoothSelectionDelegate?.smoothSelectableTableView(self, didUpdateLongPressState: .began(currentIndexPath))
        case .changed:
            guard let beganIndexPath = self.selectedIndexPaths.first,
                  currentIndexPath.section == beganIndexPath.section else {
                return
            }
            let sorted = [beganIndexPath.row, currentIndexPath.row].sorted()
            let array = Array(sorted[0]...sorted[1])
            var indexPaths = [IndexPath]()
            array.enumerated().forEach { args in
                let row = beganIndexPath.row < currentIndexPath.row ? args.element : beganIndexPath.row - args.offset
                indexPaths.append(IndexPath(row: row, section: beganIndexPath.section))
            }
            if indexPaths != self.selectedIndexPaths {
                // 差分があれば更新通知を送る
                self.smoothSelectionDelegate?.smoothSelectableTableView(self, didUpdateLongPressState: .changed(indexPaths))
            }
            self.selectedIndexPaths = indexPaths
        case .ended:
            self.selectedIndexPaths = []
            self.smoothSelectionDelegate?.smoothSelectableTableView(self, didUpdateLongPressState: .ended(currentIndexPath))
        default:
            break
        }
    }
}
