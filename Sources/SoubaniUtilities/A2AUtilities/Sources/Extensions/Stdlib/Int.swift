//
//  Int.swift
//  A2AUtilities
//
//  Created by Mohammad Farhan on 9/8/20.
//  Copyright © 2020 A2A. All rights reserved.
//

import UIKit

public extension Int {
    var cgFloat: CGFloat {
        CGFloat(self)
    }
    
    var string: String {
        String(self)
    }
}

public extension Int {
    var amountFormatted: String {
        return String(format: "%.3f", Double(self))
    }
}
