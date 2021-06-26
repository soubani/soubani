//
//  StoryboardIdentifier.swift
//  A2AUtilities
//
//  Created by Mohammad Farhan on 9/8/20.
//  Copyright © 2020 A2A. All rights reserved.
//

import Foundation

public struct StoryboardIdentifier: RawRepresentable {
    public let rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

public extension StoryboardIdentifier {
    static let main = StoryboardIdentifier(rawValue: "Main")
}
