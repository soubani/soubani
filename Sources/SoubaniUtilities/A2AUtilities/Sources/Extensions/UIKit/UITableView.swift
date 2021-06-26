//
//  UITableView.swift
//  A2AUtilities
//
//  Created by Mohammad Farhan on 9/8/20.
//  Copyright © 2020 A2A. All rights reserved.
//

import UIKit

extension UITableViewCell: Reusable { }

public extension UITableView {
    func register<T: UITableViewCell>(cell: T.Type) {
        let nib = UINib(nibName: T.identifier, bundle: Bundle(for: cell))
        register(nib, forCellReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(at indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Error dequeuing cell for identifier \(T.identifier)")
        }
        return cell
    }
}

public extension UITableView {
    private static let defaultHeaderFooterIdentifier = "Header"
    
    func register<T: UITableViewHeaderFooterView>(headerFooterView type: T.Type) {
        let nib = UINib(nibName: String(describing: type), bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: UITableView.defaultHeaderFooterIdentifier)
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        let identifier = UITableView.defaultHeaderFooterIdentifier
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: identifier) as? T else {
            fatalError("Error dequeuing headerFooterView")
        }
        return headerFooterView
    }
}
