//
//  UIViewController+Childs.swift
//  A2AUtilities
//
//  Created by Mohammad Farhan on 9/8/20.
//  Copyright © 2020 A2A. All rights reserved.
//

import UIKit

public extension UIViewController {
    func add(_ child: UIViewController, to containerView: UIView) {
        addChild(child)
        child.view.addStretchedSubview(to: containerView)
        child.didMove(toParent: self)
    }
    func add(_ child: UIViewController) {
        addChild(child)
        child.view.addStretchedSubview(to: view)
        child.didMove(toParent: self)
    }
    func add(_ child: UITableViewController, to containerView: UIView) {
        addChild(child)
        child.view.addStretchedSubview(to: containerView)
        child.didMove(toParent: self)
    }
    func add(_ child: UITableViewController) {
        addChild(child)
        child.view.addStretchedSubview(to: view)
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
