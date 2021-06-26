//
//  AuthenticationError.swift
//  A2AUtilities
//
//  Created by Mohammad Farhan on 9/8/20.
//  Copyright © 2020 A2A. All rights reserved.
//

import Foundation
import LocalAuthentication

public enum AuthenticationError: Error {
    case failed
    case fallback
    case canceled
    case passcodeNotSet
    case biometryNotAvailable
    case biometryNotEnrolled
    case biometryLockedout
    case other
    case underlying(Error)
    case custom(String)
    
    static func makeError(_ error: Error?) -> AuthenticationError {
        guard let authError = error as? LAError else { return .other }
        let errorCode = Int32(authError.errorCode)
        switch errorCode {
        case kLAErrorAuthenticationFailed:
            return failed
        case kLAErrorUserCancel, kLAErrorSystemCancel:
            return canceled
        case kLAErrorUserFallback:
            return fallback
        case kLAErrorPasscodeNotSet:
            return passcodeNotSet
        case kLAErrorBiometryNotAvailable:
            return biometryNotAvailable
        case kLAErrorBiometryNotEnrolled:
            return biometryNotEnrolled
        case kLAErrorBiometryLockout:
            return biometryLockedout
        default:
            return other
        }
    }
}

extension AuthenticationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .canceled, .fallback:
            return ""
        case .passcodeNotSet:
            return AuthenticationTexts.passcodeNotSet.message
        case .biometryNotAvailable:
            return AuthenticationTexts.biometryNotAvailable.message
        case .biometryNotEnrolled:
            return AuthenticationTexts.biometryNotEnrolled.message
        case .biometryLockedout:
            return AuthenticationTexts.passcodeAuthenticationReason.message
        case let .underlying(error):
            return error.localizedDescription
        case let .custom(string):
            return string
        default:
            return AuthenticationTexts.biometryAuthenticationReason.message
        }
    }
}
