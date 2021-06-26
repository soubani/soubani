//
//  UIActivityIndicatorView.swift
//  A2AUtilities
//
//  Created by Abudallah on 09/12/2020.
//  Copyright © 2020 A2A. All rights reserved.
//

import Foundation
import UIKit

public extension UIActivityIndicatorView {
   func start() {
        isHidden = false
        startAnimating()
    }
    
   func end() {
        isHidden = true
        stopAnimating()
    }
}
