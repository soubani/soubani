//
//  BiometricAuthenticator.swift
//  A2AUtilities
//
//  Created by Mohammad Farhan on 9/8/20.
//  Copyright © 2020 A2A. All rights reserved.
//

import Foundation
import LocalAuthentication

public final class BiometricAuthenticator: BiometricAuthenticatable {
    private lazy var context: LAContext = { .init() }()
    public var allowableReuseDuration: TimeInterval? = nil {
        didSet {
            guard let duration = allowableReuseDuration else { return }
            context.touchIDAuthenticationAllowableReuseDuration = duration
        }
    }
    
    public init() {
    
    }
}

public extension BiometricAuthenticator {
    static var biometryType: BiometryType {
        let context = LAContext()
        _ = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        return BiometryType.makeType(context.biometryType)
    }
    
    var canAuthenticate: Bool {
        var isBiometricAuthenticationAvailable = false
        var error: NSError?
        if LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            isBiometricAuthenticationAvailable = (error == nil)
        }
        return isBiometricAuthenticationAvailable
    }
    
    func authenticate(_ handler: @escaping AuthenticationHandler) {
        let context: LAContext = isReuseDurationSet ? self.context : LAContext()
        let reasonText = AuthenticationTexts.biometryAuthenticationReason.message
        evaluate(policy: .deviceOwnerAuthentication, with: context, reason: reasonText, handler: handler)
    }
}

// MARK: - Helper Methods

private extension BiometricAuthenticator {
    var isReuseDurationSet: Bool {
        return allowableReuseDuration != nil
    }

    func evaluate(
        policy: LAPolicy,
        with context: LAContext,
        reason: String,
        handler: @escaping AuthenticationHandler
    ) {
        context.evaluatePolicy(policy, localizedReason: reason) { (success, error) in
            DispatchQueue.main.async {
                if success {
                    handler(.success(()))
                } else {
                    let authenticationError = AuthenticationError.makeError(error)
                    handler(.failure(authenticationError))
                }
            }
        }
    }
}
