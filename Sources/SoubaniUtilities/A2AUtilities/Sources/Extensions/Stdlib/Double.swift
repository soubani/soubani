//
//  Double.swift
//  A2AUtilities
//
//  Created by Mohammad Farhan on 1/1/21.
//  Copyright © 2021 A2A. All rights reserved.
//

import Foundation

public extension Double {
    var amountFormatted: String {
        return String(format: "%.3f", self)
    }
}
