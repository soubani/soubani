//
//  Filtered.swift
//  A2AUtilities
//
//  Created by Mohammad Farhan on 9/8/20.
//  Copyright © 2020 A2A. All rights reserved.
//

import Foundation

public typealias SectionedFilteredItem = Searchable & Groupable

@propertyWrapper
public final class Filtered<T: Searchable> {
    
    public private(set) var searchText = ""
    private var isSearching: Bool { searchText.nilIfEmpty != nil }
    public var projectedValue: Filtered<T> { self }
    public var wrappedValue: State<T> = .loading
    
    public var filtered: State<T> {
        if isSearching {
            let items = wrappedValue.items.filter { $0.query.range(of: searchText, options: .caseInsensitive) != nil }
            return .populated(items)
        } else {
            return wrappedValue
        }
    }
    
    public init(state wrappedValue: State<T> = .loading) {
        self.wrappedValue = wrappedValue
    }
    
    public func search(with searchText: String) {
        self.searchText = searchText
    }
    
    public func item(at indexPath: IndexPath) -> T {
        isSearching ? filtered.items[indexPath.row] : wrappedValue.items[indexPath.row]
    }
}

@propertyWrapper
public final class SectionedFiltered<T: SectionedFilteredItem> {
    
    public private(set) var searchText = ""
    private var isSearching: Bool { searchText.nilIfEmpty != nil }
    public var projectedValue: SectionedFiltered<T> { self }
    public var wrappedValue: State<[T]> = .loading

    public var filtered: State<[T]> {
        if isSearching {
            let items = wrappedValue.items
                .flatMap { $0 }
                .filter { $0.query.range(of: searchText, options: .caseInsensitive) != nil }
                .group { $0.groupBy }
            return .populated(items)
        } else {
            return wrappedValue
        }
    }
    
    public init(state wrappedValue: State<[T]> = .loading) {
        self.wrappedValue = wrappedValue
    }
    
    public func search(with searchText: String) {
        self.searchText = searchText
    }
    
    public func item(at indexPath: IndexPath) -> T {
        let state = isSearching ? filtered : wrappedValue
        return state.items[indexPath.section][indexPath.row]
    }
}
