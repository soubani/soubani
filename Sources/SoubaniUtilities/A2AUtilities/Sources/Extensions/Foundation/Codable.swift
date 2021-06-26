//
//  Codable.swift
//  A2AUtilities
//
//  Created by Mohammad Farhan on 9/8/20.
//  Copyright © 2020 A2A. All rights reserved.
//

import Foundation

public typealias JSONDictionary = [String: Any]

public extension Encodable {
    func encoded() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonDictionary() throws -> JSONDictionary {
        let data: Data = try encoded()
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        guard JSONSerialization.isValidJSONObject(jsonObject),
            let jsonDictionary = jsonObject as? JSONDictionary
        else {
            throw JSONError()
        }
        return jsonDictionary
    }
}

private struct JSONError: Error, LocalizedError {
    var errorDescription: String? { "Failed to map data to JSON." }
}
