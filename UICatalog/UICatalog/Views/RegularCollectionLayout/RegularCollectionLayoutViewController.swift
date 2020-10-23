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
            newValue.register(RightLargeTableCell.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension RegularCollectionLayoutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let num = indexPath.row % 4
        if num == 0 || num == 2 {
            let cell = self.linerSmallTableCell(tableView.dequeueReusableCell(for: indexPath), cellId: indexPath.row)
            return cell
        } else if num == 1 {
            let cell = self.leftLargeTableCell(tableView.dequeueReusableCell(for: indexPath), cellId: indexPath.row)
            return cell
        } else if num == 3 {
            let cell = self.rightLargeTableCell(tableView.dequeueReusableCell(for: indexPath), cellId: indexPath.row)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    private func linerSmallTableCell(_ cell: LinerSmallTableCell, cellId: Int) -> LinerSmallTableCell {
        cell.configure(cellId: cellId)
        return cell
    }
    
    private func leftLargeTableCell(_ cell: LeftLargeTableCell, cellId: Int) -> LeftLargeTableCell {
        cell.configure(cellId: cellId)
        return cell
    }
    
    private func rightLargeTableCell(_ cell: RightLargeTableCell, cellId: Int) -> RightLargeTableCell {
        cell.configure(cellId: cellId)
        return cell
    }
}
