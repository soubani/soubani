//
//  UIView+Inspectable.swift
//  A2AUtilities
//
//  Created by Mohammad Farhan on 9/8/20.
//  Copyright © 2020 A2A. All rights reserved.
//

import UIKit

public extension UIView {
    var size: CGSize {
        get { frame.size }
        set {
            width = newValue.width
            height = newValue.height
        }
    }

    var width: CGFloat {
        get { frame.size.width }
        set { frame.size.width = newValue }
    }

    var height: CGFloat {
        get { frame.size.height }
        set { frame.size.height = newValue }
    }
}

public extension UIView {
//    @IBInspectable var borderWidth: CGFloat {
//        set { layer.borderWidth = newValue }
//        get { layer.borderWidth }
//    }
//
    @IBInspectable var cornerRadiuss: CGFloat {
        set { layer.cornerRadius = newValue }
        get { layer.cornerRadius }
    }
//
//    @IBInspectable var borderColor: UIColor? {
//        set {
//            guard let uiColor = newValue else { return }
//            layer.borderColor = uiColor.cgColor
//        } get {
//            guard let color = layer.borderColor else { return nil }
//            return UIColor(cgColor: color)
//        }
//    }
//    
    @IBInspectable var circleCorner: Bool {
        get { min(bounds.size.height, bounds.size.width) / 2 == cornerRadiuss }
        set { cornerRadiuss = newValue ? min(bounds.size.height, bounds.size.width) / 2 : cornerRadiuss }
    }
}
