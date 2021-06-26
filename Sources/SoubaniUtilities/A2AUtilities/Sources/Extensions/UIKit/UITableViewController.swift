//
//  UITableViewController.swift
//  A2AUtilities
//
//  Created by Mohammad Farhan on 10/6/20.
//  Copyright © 2020 A2A. All rights reserved.
//

import UIKit

extension UITableViewController {
    open override func awakeFromNib() {
        super.awakeFromNib()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension UITableViewCell {
    var indexPath: IndexPath? {
        guard let tableView = superview as? UITableView else { return nil }
        return tableView.indexPath(for: self)
    }
}

