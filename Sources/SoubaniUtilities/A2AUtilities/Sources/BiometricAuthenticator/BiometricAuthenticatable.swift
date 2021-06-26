//
//  BiometricAuthenticatable.swift
//  A2AUtilities
//
//  Created by Mohammad Farhan on 9/8/20.
//  Copyright © 2020 A2A. All rights reserved.
//

import Foundation
import LocalAuthentication

public typealias AuthenticationResult = Swift.Result<Void, AuthenticationError>

public protocol BiometricAuthenticatable {
    typealias AuthenticationHandler = (AuthenticationResult) -> Void
    
    var allowableReuseDuration: TimeInterval? { get set }
    var canAuthenticate: Bool { get }
    
    static var biometryType: BiometryType { get }
    
    func authenticate(_ handler: @escaping AuthenticationHandler)
}

public enum BiometryType {
    case faceID
    case touchID
    case none
    
    static func makeType(_ type: LABiometryType) -> BiometryType {
        switch type {
        case .faceID: return .faceID
        case .touchID: return .touchID
        default: return .none
        }
    }
}
