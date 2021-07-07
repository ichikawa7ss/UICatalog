//
//  LongPressableViewController.swift
//  UICatalog
//
//  Created by ichikawa on 2021/06/23.
//  Copyright © 2021 ichikawa. All rights reserved.
//

import UIKit

final class LongPressableViewController: UIViewController {
    
    @IBOutlet fileprivate weak var collectionView: UICollectionView! {
        willSet {
            newValue.register(WEARItemCollectionCell.self)
        }
    }
    var longPressRecognizer: UILongPressGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.reloadData()
        self.setupLongPressGesture()
    }
}

extension LongPressableViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionViewCell(collectionView.dequeueReusableCell(for: indexPath), indexPath: indexPath)
        return cell
    }
    
    private func collectionViewCell(_ cell: WEARItemCollectionCell, indexPath: IndexPath) -> WEARItemCollectionCell {
        cell.configure(cellId: indexPath.row)
        return cell
    }
}

extension LongPressableViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return WEARItemCollectionCell.size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}

extension LongPressableViewController: UIGestureRecognizerDelegate {
    
    func setupLongPressGesture() {
        self.longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longTapped))
        self.longPressRecognizer?.allowableMovement = 15
        self.longPressRecognizer?.minimumPressDuration = 0.2
        self.collectionView.addGestureRecognizer(self.longPressRecognizer!)
        self.longPressRecognizer!.delegate = self
    }
    
    @objc
    func longTapped(recognizer: UILongPressGestureRecognizer) {
        let currentPoint = self.longPressRecognizer!.location(in: collectionView)
        let currentRow = self.collectionView.indexPathForItem(at: currentPoint)
        switch recognizer.state {
        case .began:
            
            print(currentRow)
        case .changed:
            print(currentRow)
        case .ended:
            print(currentRow)
        default:
            break
        }
    }
    
    func boundsView() {
        
    }
}
