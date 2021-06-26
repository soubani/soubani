//
//  Sequence.swift
//  A2AUtilities
//
//  Created by Mohammad Farhan on 9/8/20.
//  Copyright © 2020 A2A. All rights reserved.
//

import Foundation

public extension Sequence {
    func group<K: Hashable & Comparable>(by keyForValue: (Element) -> K) -> [[Element]] {
        return Dictionary(grouping: self, by: keyForValue).sorted { $0.key < $1.key }.map { $0.value }
    }
}
