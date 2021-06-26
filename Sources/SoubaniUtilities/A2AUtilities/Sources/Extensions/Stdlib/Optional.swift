//
//  Optional.swift
//  A2AUtilities
//
//  Created by Mohammad Farhan on 9/8/20.
//  Copyright © 2020 A2A. All rights reserved.
//

import Foundation

// MARK: - String

public extension Optional where Wrapped == String {
    var nilIfEmpty: String? {
        guard let self = self else { return nil }
        return self.isBlank ? nil : self
    }
    
    var defaultIfEmpty: String {
        switch self {
        case let .some(value):
            return value.nilIfEmpty ?? ""
        case .none:
            return ""
        }
    }
    
    var amountFormatted: String {
        return String(format: "%.3f", Double(self.defaultIfEmpty).defaultIfEmpty)
    }
}

// MARK: - Character

public extension Optional where Wrapped == Character {
    var defaultIfEmpty: Character {
        switch self {
        case let .some(value):
            return value
        case .none:
            return Character("")
        }
    }
}

// MARK: - Int

public extension Optional where Wrapped == Int {
    var defaultIfEmpty: Int {
        switch self {
        case let .some(value):
            return value
        case .none:
            return 0
        }
    }
    
    var amountFormatted: String {
        return String(format: "%.3f", Double(self.defaultIfEmpty))
    }
}

public extension Optional where Wrapped == Double {
    var defaultIfEmpty: Double {
        switch self {
        case let .some(value):
            return value
        case .none:
            return 0.0
        }
    }
    
    var amountFormatted: String {
        return String(format: "%.3f", self.defaultIfEmpty)
    }
}

// MARK: - Bool

public extension Optional where Wrapped == Bool {
    var defaultIfEmpty: Bool {
        switch self {
        case let .some(value):
            return value
        case .none:
            return false
        }
    }
}
