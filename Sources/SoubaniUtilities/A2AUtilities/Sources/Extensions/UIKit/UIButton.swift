//
//  UIButton.swift
//  A2AUtilities
//
//  Created by Abudallah on 10/9/20.
//  Copyright © 2020 A2A. All rights reserved.
//

import Foundation
import UIKit

public extension UIButton {
    
    func underline() {
        guard let text = titleLabel?.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(
            NSAttributedString.Key.underlineColor,
            value: titleColor(for: .normal) ?? .black,
            range: NSRange(location: .zero, length: text.count)
        )
        attributedString.addAttribute(
            NSAttributedString.Key.foregroundColor,
            value: titleColor(for: .normal) ?? .black,
            range: NSRange(location: .zero, length: text.count)
        )
        attributedString.addAttribute(
            NSAttributedString.Key.underlineStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: .zero, length: text.count)
        )
        setAttributedTitle(attributedString, for: .normal)
    }
    
    // MARK: Animate check mark
    
    func checkboxAnimation(closure: @escaping () -> Void) {
        guard let image = self.imageView else {return}
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear) {
            image.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        } completion: { [weak self] _ in
            guard let self = self else { return }
            UIView.animate(withDuration: 0.1, delay: .zero, options: .curveLinear, animations: {
                self.isSelected.toggle()
                closure()
                image.transform = .identity
            }, completion: nil)
        }
    }
}
