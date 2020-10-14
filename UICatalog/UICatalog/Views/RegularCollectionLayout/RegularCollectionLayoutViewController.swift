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
            newValue.register(LinerSmallTableCell.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension RegularCollectionLayoutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.linerSmallTableCell(tableView.dequeueReusableCell(for: indexPath))
        return cell
    }
    
    private func linerSmallTableCell(_ cell: LinerSmallTableCell) -> LinerSmallTableCell {
        // TODO: - Implement
        return cell
    }
}
