//
//  UICollectionView.swift
//  A2AUtilities
//
//  Created by Mohammad Farhan on 9/8/20.
//  Copyright © 2020 A2A. All rights reserved.
//

import UIKit

extension UICollectionViewCell: Reusable { }

public extension UICollectionView {
    func register<T: UICollectionViewCell>(cellType: T.Type) {
        register(cellType.self, forCellWithReuseIdentifier: T.identifier)
    }
    
    func register<T: UICollectionViewCell>(cell: T.Type) {
        let nib = UINib(nibName: T.identifier, bundle: Bundle(for: cell))
        register(nib, forCellWithReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(at indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Error dequeuing cell for identifier \(T.identifier)")
        }
        return cell
    }
}

public extension UICollectionView {
    var lastSection: Int {
        return numberOfSections > 0 ? numberOfSections - 1 : 0
    }
}
