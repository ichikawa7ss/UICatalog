//
//  RegularCollectionLayoutViewController.swift
//  UICatalog
//
//  Created by ichikawa on 2020/09/30.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

final class RegularCollectionLayoutViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView! {
        willSet {
            newValue.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
            newValue.register(LinerSmallTableCell.self)
            newValue.register(LeftLargeTableCell.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension RegularCollectionLayoutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let num = indexPath.row % 3
        if num == 0 {
            let cell = self.linerSmallTableCell(tableView.dequeueReusableCell(for: indexPath))
            return cell
        } else if num == 1 {
            let cell = self.leftLargeTableCell(tableView.dequeueReusableCell(for: indexPath))
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    private func linerSmallTableCell(_ cell: LinerSmallTableCell) -> LinerSmallTableCell {
        // TODO: - Implement
        return cell
    }
    
    private func leftLargeTableCell(_ cell: LeftLargeTableCell) -> LeftLargeTableCell {
        // TODO: - Implement
        return cell
    }
}
