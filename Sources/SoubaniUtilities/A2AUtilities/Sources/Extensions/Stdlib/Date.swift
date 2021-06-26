//
//  Date.swift
//  A2AUtilities
//
//  Created by Mohammad Farhan on 1/15/21.
//  Copyright © 2021 A2A. All rights reserved.
//

import Foundation

public extension Date {
    func toString(format: DateFormat = .yearMonthDay) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        let string = formatter.string(from: self)
        return string
    }
}
