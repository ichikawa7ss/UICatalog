//
//  ShrinkingModalChlildViewController.swift
//  UICatalog
//
//  Created by ichikawa on 2021/03/31.
//  Copyright © 2021 ichikawa. All rights reserved.
//

import UIKit

final class ShrinkingModalChildViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView! {
        willSet {
            newValue.register(ShrinkingCell.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ShrinkingModalChildViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.shrinkingCell(tableView.dequeueReusableCell(for: indexPath))
        return cell
    }
    
    private func shrinkingCell(_ cell: ShrinkingCell) -> ShrinkingCell {
        cell.configure()
        return cell
    }
}
