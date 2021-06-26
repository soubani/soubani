//
//  Dynamic.swift
//  A2AUtilities
//
//  Created by Mohammad Farhan on 9/8/20.
//  Copyright © 2020 A2A. All rights reserved.
//

import Foundation

public final class Dynamic<Value> {
    
    public typealias Listener = (Value) -> Void
    
    private var listener: Listener?
    
    public var value: Value {
        didSet { listener?(value) }
    }
    
    public init(_ value: Value) {
        self.value = value
    }
    
    public func bind(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
