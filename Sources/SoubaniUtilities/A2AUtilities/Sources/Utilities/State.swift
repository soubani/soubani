//
//  State.swift
//  A2AUtilities
//
//  Created by Mohammad Farhan on 9/8/20.
//  Copyright © 2020 A2A. All rights reserved.
//

import Foundation

public enum State<Value> {
    case loading
    case paging([Value], nextPage: Int)
    case populated([Value])
    case empty
    case error(Error)
    
    public var items: [Value] {
        switch self {
        case let .paging(items, _):
            return items
        case let .populated(items):
            return items
        default:
            return []
        }
    }
    
    public mutating func delete(at index: Int) {
        switch self {
        case .paging(var items, let nextPage):
            items.remove(at: index)
            self = .paging(items, nextPage: nextPage)
        case var .populated(items):
            items.remove(at: index)
            self = .populated(items)
        default:
            return
        }
    }
    
    public mutating func update(_ item: Value, at index: Int) {
        switch self {
        case .paging(var items, let nextPage):
            items[index] = item
            self = .paging(items, nextPage: nextPage)
        case var .populated(items):
            items[index] = item
            self = .populated(items)
        default:
            return
        }
    }
    
    public mutating func update(_ items: [Value]) {
        switch self {
        case .paging(_, let nextPage):
            self = .paging(items, nextPage: nextPage)
        case .populated:
            self = .populated(items)
        default:
            return
        }
    }
    
    public mutating func insert(_ item: Value, at index: Int) {
        switch self {
        case .paging(var items, let nextPage):
            items.insert(item, at: index)
            self = .paging(items, nextPage: nextPage)
        case var .populated(items):
            items.insert(item, at: index)
            self = .populated(items)
        default:
            return
        }
    }
}

extension State: Equatable {
    public static func == (lhs: State<Value>, rhs: State<Value>) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case (.paging, .paging): return true
        case (.populated, .populated): return true
        case (.empty, .empty): return true
        case (.error, .error): return true
        default: return false
        }
    }
}
