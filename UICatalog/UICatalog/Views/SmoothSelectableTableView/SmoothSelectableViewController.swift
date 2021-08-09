//
//  SmoothSelectableViewController.swift
//  UICatalog
//
//  Created by ichikawa on 2021/08/09.
//  Copyright © 2021 ichikawa. All rights reserved.
//

import UIKit

final class SmoothSelectableViewController: UIViewController {
    
    @IBOutlet private weak var tableView: SmoothSelectableTableView!
    private var selectedIndex: Set<IndexPath> = []
    private var longPreesedIndex: Set<IndexPath> = []
    private var isSelecting: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.setupLongPress(self)
    }
}

extension SmoothSelectableViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SmoothSelectableCell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row + 1)番目のセル"
        let selectedAllIndex = self.isSelecting ? self.selectedIndex.union(self.longPreesedIndex) : self.selectedIndex.subtracting(self.longPreesedIndex)
        let isSelected = !selectedAllIndex.filter { $0 == indexPath }.isEmpty
        cell.backgroundColor = isSelected ? .cyan : .white
        return cell
    }
}

extension SmoothSelectableViewController: SmoothSelectableTableViewDelegate {
 
    func smoothSelectableTableView(_ tableView: SmoothSelectableTableView, didUpdateLongPressState state: SmoothSelectalbeTableViewState) {
        switch state {
        case .began(let indexPath):
            self.isSelecting = !self.selectedIndex.contains(indexPath)
            self.updateSelectedIndex(indexPath)
        case .changed(let indexPaths):
            self.longPreesedIndex = []
            indexPaths.forEach { indexPath in
                self.updateSelectedIndex(indexPath)
            }
        case .ended(let indexPath):
            self.updateSelectedIndex(indexPath)
            self.selectedIndex = self.isSelecting ? self.selectedIndex.union(self.longPreesedIndex) : self.selectedIndex.subtracting(self.longPreesedIndex)
            self.longPreesedIndex = []
        }
    }
}

extension SmoothSelectableViewController {

    private func updateSelectedIndex(_ index: IndexPath) {
        self.longPreesedIndex.insert(index)
        self.tableView.reloadData()
    }
}
