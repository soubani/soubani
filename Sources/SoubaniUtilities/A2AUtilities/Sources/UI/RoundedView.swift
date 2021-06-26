//
//  RoundedView.swift
//  A2AUtilities
//
//  Created by Mohammad Farhan on 12/18/20.
//  Copyright © 2020 A2A. All rights reserved.
//

import UIKit

@IBDesignable
public class RoundedView: UIView {

    @IBInspectable public var topLeft: Bool = false
    @IBInspectable public var topRight: Bool = false
    @IBInspectable public var bottomLeft: Bool = false
    @IBInspectable public var bottomRight: Bool = false
    @IBInspectable public var cornerRadii: Int = 0

    public override func layoutSubviews() {
        super.layoutSubviews()
        var options = UIRectCorner()

        if topLeft { options = options.union(.topLeft) }
        if topRight { options = options.union(.topRight) }
        if bottomLeft { options = options.union(.bottomLeft) }
        if bottomRight { options = options.union(.bottomRight) }

        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: options,
                                cornerRadii: CGSize(width: cornerRadii, height: cornerRadii))

        let maskLayer = CAShapeLayer()

        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
}
