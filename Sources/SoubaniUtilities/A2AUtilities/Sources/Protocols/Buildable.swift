//
//  Buildable.swift
//  A2AUtilities
//
//  Created by Mohammad Farhan on 9/8/20.
//  Copyright © 2020 A2A. All rights reserved.
//

import Foundation

public protocol Buildable { }

public extension Buildable where Self: AnyObject {
    func with<T>(
        _ property: ReferenceWritableKeyPath<Self, T>,
        _ value: T
    ) -> Self {
        self[keyPath: property] = value
        return self
    }
}

extension NSObject: Buildable { }
