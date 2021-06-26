//
//  AuthenticationTexts.swift
//  A2AUtilities
//
//  Created by Mohammad Farhan on 9/8/20.
//  Copyright © 2020 A2A. All rights reserved.
//

import Foundation

public enum AuthenticationTexts {
    case biometryNotAvailable
    case biometryNotEnrolled
    case biometryAuthenticationReason
    case passcodeAuthenticationReason
    case passcodeNotSet
    case biometryAuthenticationFailed

    public var message: String {
        let isFaceID = BiometricAuthenticator.biometryType == .faceID
        let biometryText = isFaceID ? "Face ID" : "Touch ID"
        let typeText = isFaceID ? "face" : "fingerprint"
        switch self {
        case .biometryNotAvailable:
            return "Biometric authentication is not available for this device."
        case .biometryNotEnrolled:
            return "There is no \(typeText) enrolled in the device. Please go to Device Settings -> \(biometryText) & Passcode and enroll your \(typeText)."
        case .biometryAuthenticationReason:
            return "Please confirm your \(typeText)"
        case .passcodeAuthenticationReason:
            return "\(biometryText) is locked now, because of too many failed attempts. Enter passcode to unlock \(biometryText)."
        case .passcodeNotSet:
            return "Please set device passcode to use \(biometryText) for authentication."
        case .biometryAuthenticationFailed:
            return "\(biometryText) does not recognize your \(typeText). Please try again with your enrolled \(typeText)."
        }
    }
}
