//
//  UIView.swift
//  A2AUtilities
//
//  Created by Mohammad Farhan on 9/8/20.
//  Copyright © 2020 A2A. All rights reserved.
//

import UIKit

public extension UIView {
    func findViewController() -> UIViewController? {
        if let nextResponder = next as? UIViewController {
            return nextResponder
        } else if let nextResponder = next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}

public extension UIView {
    func loadFromNib() {
        guard let subView = UINib(nibName: "\(type(of: self))", bundle: Bundle(for: type(of: self)))
                .instantiate(withOwner: self, options: nil).first as? UIView
        else { return }
        
        subView.frame = bounds
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(subView)
    }
    
    static func instantiate() -> Self {
        func instantiate<T: UIView>() -> T {
            let nib = UINib(nibName: "\(self)", bundle: Bundle(for: self))
            guard let view = nib.instantiate(withOwner: nil, options: nil).first as? T else {
                fatalError("Could not instantiate view \(self)")
            }
            return view
        }
        
        return instantiate()
    }
    
    static func loadFromNib(named name: String, bundle: Bundle) -> UIView {
        let nib = UINib(nibName: name, bundle: bundle)
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? UIView else {
            fatalError("Could not instantiate view")
        }
        return view
    }
}

public extension UIView {
    func addStretchedSubview(to parentView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(self)
        let views = ["subview": self]
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subview]|", options: .directionLeadingToTrailing, metrics: nil, views: views))
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subview]|", options: .directionLeadingToTrailing, metrics: nil, views: views))
    }
}

public extension UIView {
    
    func makeItCircle() {
        layer.cornerRadius = bounds.size.height / 2
        layer.masksToBounds = true
    }

    func roundTop(radius: CGFloat = 6) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
    }
    
    func roundBottom(radius: CGFloat = 6) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
    }
    
    func round(with maskedCorners: CACornerMask?, radius: CGFloat = 7) {
        guard let masked = maskedCorners else { return }
        clipsToBounds = true
        layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            layer.maskedCorners = masked
        }
    }
}

// MARK: - DashedBorder

public extension UIView {
    func addDashedBorder(
        _ color: UIColor = UIColor.black,
        withWidth width: CGFloat = 0.5,
        cornerRadius: CGFloat = 5,
        dashPattern: [NSNumber] = [3, 6]
    ) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = bounds
        shapeLayer.position = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round // Updated in swift 4.2
        shapeLayer.lineDashPattern = dashPattern
        shapeLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        layer.addSublayer(shapeLayer)
    }
}

public class CustomDashedView: UIView {

    @IBInspectable public var corner: CGFloat = 0 {
        didSet {
            layer.cornerRadius = corner
            layer.masksToBounds = corner > 0
        }
    }
    @IBInspectable var dashWidth: CGFloat = 0
    @IBInspectable var dashColor: UIColor = .clear
    @IBInspectable var dashLength: CGFloat = 0
    @IBInspectable var betweenDashesSpace: CGFloat = 0

    var dashBorder: CAShapeLayer?

    public override func layoutSubviews() {
        super.layoutSubviews()
        dashBorder?.removeFromSuperlayer()
        let dashBorder = CAShapeLayer()
        dashBorder.lineWidth = dashWidth
        dashBorder.strokeColor = dashColor.cgColor
        dashBorder.lineDashPattern = [dashLength, betweenDashesSpace] as [NSNumber]
        dashBorder.frame = bounds
        dashBorder.fillColor = nil
        if cornerRadiuss > 0 {
            dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadiuss).cgPath
        } else {
            dashBorder.path = UIBezierPath(rect: bounds).cgPath
        }
        layer.addSublayer(dashBorder)
        self.dashBorder = dashBorder
    }
}

@IBDesignable
public class ShadowViewA2A: UIView {

    @IBInspectable var viewShadowColor: UIColor = UIColor.black {
        didSet { self.updateView() }
    }
    @IBInspectable var viewShadowOpacity: Float = 0.5 {
        didSet { self.updateView() }
    }
    @IBInspectable var viewShadowOffset: CGSize = CGSize(width: 3, height: 3) {
        didSet { self.updateView() }
    }
    @IBInspectable var viewShadowRadius: CGFloat = 15.0 {
        didSet { self.updateView() }
    }
    @IBInspectable var viewCornerRadius: CGFloat = 0 {
        didSet { self.updateView() }
    }
    @IBInspectable var viewBorderColor: UIColor = UIColor.black {
        didSet { self.updateView() }
    }
    @IBInspectable var viewBorderWidth: CGFloat = 0.0 {
        didSet { self.updateView() }
    }

    func updateView() {
        layer.shadowColor = self.viewShadowColor.cgColor
        layer.shadowOpacity = self.viewShadowOpacity
        layer.shadowOffset = self.viewShadowOffset
        layer.shadowRadius = self.viewShadowRadius
        layer.borderWidth = self.viewBorderWidth
        layer.cornerRadius = self.viewCornerRadius
    }
}

public extension UIView {
    func addUnderLineToView(unselectViews: [UIView]) {
        let size = CGRect(x: .zero, y: frame.size.height, width: frame.size.width, height: 4)
        let lineView = UIView(frame: size)
        lineView.tag = 777
        lineView.backgroundColor = .white
        addSubview(lineView)
        unselectViews.forEach { view in
            view.subviews.forEach { if $0.tag == 777 { $0.removeFromSuperview() } }
        }
    }
}



@IBDesignable
class CardView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 2
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 1
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.1
    @IBInspectable var borderWidth: CGFloat = 0.0
    @IBInspectable var borderColor: UIColor? = UIColor.black
    @IBInspectable var cornerRadiusBorder: Int = 0
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 3, height: 3)

    override func layoutSubviews() {

//        layer.cornerRadius = cornerRadius
//        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
//        layer.masksToBounds = false
//        layer.shadowColor = shadowColor?.cgColor
//        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
//        layer.shadowOpacity = shadowOpacity
//        layer.shadowPath = shadowPath.cgPath
//        layer.borderWidth = borderWidth
//        layer.borderColor = borderColor?.cgColor
//        layer.cornerRadius = cornerRadius
        
        self.layer.shadowColor = self.shadowColor?.cgColor
        self.layer.shadowOpacity = 0.2 //self.shadowOpacity
        self.layer.shadowOffset = self.shadowOffset
        self.layer.shadowRadius = 10
        self.layer.cornerRadius = self.cornerRadius
    }
}

@IBDesignable
class shadowView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 2
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 1
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.1
    @IBInspectable var borderWidth: CGFloat = 0.0
    @IBInspectable var borderColor: UIColor? = UIColor.black
    @IBInspectable var cornerRadiusBorder: Int = 0
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 3, height: 3)

    override func layoutSubviews() {

        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor?.cgColor
        layer.cornerRadius = cornerRadius
    
    }
}
