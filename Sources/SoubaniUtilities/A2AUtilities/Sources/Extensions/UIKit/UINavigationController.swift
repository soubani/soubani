//
//  UINavigationController.swift
//  A2AUtilities
//
//  Created by Hanan on 29/12/2020.
//  Copyright © 2020 A2A. All rights reserved.
//

import UIKit

public extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let controller = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(controller, animated: animated)
    }
  }
}
