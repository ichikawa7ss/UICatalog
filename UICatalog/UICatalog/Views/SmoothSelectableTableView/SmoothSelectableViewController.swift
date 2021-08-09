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
        return cell
    }
}

extension SmoothSelectableViewController: SmoothSelectableTableViewDelegate {
 
    func smoothSelectableTableView(_ tableView: SmoothSelectableTableView, didUpdateLongPressState state: SmoothSelectalbeTableViewState) {
        print("didUpdateLongPressState: \(state)")
    }
}
