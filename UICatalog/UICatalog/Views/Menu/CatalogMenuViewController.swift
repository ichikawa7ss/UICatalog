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
        return UIMenu.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menu = UIMenu.init(rawValue: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        cell.textLabel?.text = menu?.title
        return cell
    }
}

extension CatalogMenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menu = UIMenu.init(rawValue: indexPath.row) else { return }
        
        switch menu {
        case .searchAnimation:
            let vc = SearchAnimationViewController.instantiate()
            self.navigationController?.pushViewController(vc, animated: true)
//        case .switchableViewController:
//            let vc = SwitchableRootViewController.instantiate()
//            vc.chiledViewControllers = [
//                HomeViewController.instantiate(),
//                SearchViewController.instantiate()
//            ]
//            self.navigationController?.pushViewController(vc, animated: true)
        case .regularCollectionLayout:
            let vc = RegularCollectionLayoutViewController.instantiate()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

enum UIMenu: Int, CaseIterable {
    
    case searchAnimation
//    case switchableViewController
    case regularCollectionLayout
    
    var title: String {
        switch self {
        case .searchAnimation:
            return "Search Animation like facebook"
//        case .switchableViewController:
//            return "Switching ViewController animation"
        case .regularCollectionLayout:
            return "Regular Collection Layout like WEAR"
        }
    }
}
