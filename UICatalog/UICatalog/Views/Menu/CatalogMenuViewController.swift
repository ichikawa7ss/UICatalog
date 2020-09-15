//
//  CatalogMenuViewController.swift
//  UICatalog
//
//  Created by ichikawa on 2020/09/16.
//  Copyright © 2020 ichikawa. All rights reserved.
//

import UIKit

final class CatalogMenuViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CatalogMenuViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
