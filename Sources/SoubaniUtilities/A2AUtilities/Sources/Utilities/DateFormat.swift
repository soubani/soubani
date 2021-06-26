//
//  DateFormat.swift
//  A2AUtilities
//
//  Created by Mohammad Farhan on 9/8/20.
//  Copyright © 2020 A2A. All rights reserved.
//

import Foundation

public struct DateFormat: RawRepresentable {
    public private(set) var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

public extension DateFormat {
    static let utc = DateFormat(rawValue: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
    static let iso = DateFormat(rawValue: "yyyy-MM-dd'T'HH:mm:ss+0000")
    static let jsonDateTime = DateFormat(rawValue: "yyyy-MM-dd HH:mm:ss")
    static let yearMonthDay = DateFormat(rawValue: "yyyy-MM-dd")
    static let year = DateFormat(rawValue: "yyyy")
    static let minuteHour = DateFormat(rawValue: "HH:mm")
    static let defaultDateTime = DateFormat(rawValue: "MMM, dd yyy hh:mm a")
    static let dayMonthYearSlashed = DateFormat(rawValue: "dd/MM/yyyy")
    static let fullDateTime = DateFormat(rawValue: "E MMM dd, yyyy HH:mm")
    static let defaultDate = DateFormat(rawValue: "MMMM dd, yyyy")
    static let defaultTime = DateFormat(rawValue: "hh:mm a")
}
