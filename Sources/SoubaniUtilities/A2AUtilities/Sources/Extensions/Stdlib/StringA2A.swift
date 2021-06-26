//
//  String.swift
//  A2AUtilities
//
//  Created by Mohammad Farhan on 9/8/20.
//  Copyright © 2020 A2A. All rights reserved.
//

import Foundation

public extension String {
    var trimmed: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var isBlank: Bool {
        trimmed.isEmpty
    }
    
    var nilIfEmpty: String? {
        isBlank ? nil : self
    }
    
    var isNotEmpty: Bool {
        !isEmpty
    }
    
    var defaultIfEmpty: String {
        isBlank ? "" : self
    }
    
    var int: Int? {
        return Int(self)
    }
    
    var double: Double? {
        return Double(self)
    }
    
    var hasDigits: Bool {
        let numbersRange = rangeOfCharacter(from: .decimalDigits)
        return numbersRange != nil
    }
    
    var hasSpecialCharachters: Bool {
        let regex = "[a-zA-Z0-9!@#$%^&*]+"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    var isValidPasswordLength: Bool {
        switch count {
        case 6...10: return true
        default: return false
        }
    }
    
    func mask(lastDigits digits: Int) -> String {
        
        let maxMaskValue = self.suffix(digits)
        return  "xxxxxxx\(maxMaskValue)"
    }
}

public extension String {
    var withCurrency: String {
        self + " JOD"
    }
}

public extension String {
    var amountFormatted: String {
        return String(format: "%.3f", Double(self).defaultIfEmpty)
    }
}

public extension String {
    var space: String {
        return self + " "
    }
}

public extension String {
    func toDateString(fromFormat: DateFormat = .iso, toFormat: DateFormat) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat.rawValue
        let date = dateFormatter.date(from: self)
        return date?.toString(format: toFormat)
    }
}

public extension String {
    func substring(with range: Range<Int>) -> String {
        let startIndex = index(from: range.lowerBound)
        let endIndex = index(from: range.upperBound)
        return substring(with: startIndex..<endIndex)
    }
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
}

extension String  {
    var isValidAmount: Bool  {
           let regex = "(?<![\\d.])(\\d{1,6}|\\d{0,6}\\.\\d{0,3})?(?![\\d.])"
           let testResult = NSPredicate(format: "SELF MATCHES %@", regex)
           return testResult.evaluate(with: self)
       }
}
