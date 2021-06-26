//
//  UIViewController+Router.swift
//  A2AUtilities
//
//  Created by Mohammad Farhan on 9/8/20.
//  Copyright © 2020 A2A. All rights reserved.
//

import UIKit
import SafariServices

public extension UIViewController {
    func present<T: UIViewController>(
        _ viewController: T,
        withNavigation: Bool = false,
        animated: Bool = true,
        modalPresentationStyle: UIModalPresentationStyle = .fullScreen,
        completion: (() -> Void)? = nil
    ) {
        viewController.modalPresentationStyle = modalPresentationStyle
        if withNavigation {
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.modalPresentationStyle = modalPresentationStyle
            present(navigationController, animated: animated, completion: completion)
        } else {
            present(viewController, animated: animated, completion: completion)
        }
    }
    
    func show<T: UIViewController>(
        _ viewController: T,
        animated: Bool = true,
        hideBackButton: Bool = false,
        hidesBottomBarWhenPushed: Bool = true
    ) {
        let barButtonItem = UIBarButtonItem()
        barButtonItem.title = ""
        navigationItem.backBarButtonItem = barButtonItem
        viewController.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
        navigationItem.setHidesBackButton(hideBackButton, animated: true)
        viewController.navigationItem.setHidesBackButton(hideBackButton, animated: true)
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func present(
        safari url: String,
        modalPresentationStyle: UIModalPresentationStyle = .fullScreen,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        guard let url = URL(string: url) else { return }
        if ["http", "https"].contains(url.scheme?.lowercased() ?? "") {
            let safariController = SFSafariViewController(url: url)
            safariController.modalPresentationStyle = modalPresentationStyle
            present(safariController, animated: animated, completion: completion)
        } else {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func dismissViewController(animated: Bool = true) {
        guard let navigationController = navigationController else {
            dismiss(animated: animated)
            return
        }
        guard navigationController.viewControllers.count > 1 else {
            return navigationController.dismiss(animated: animated)
        }
        navigationController.popViewController(animated: animated)
    }
}
