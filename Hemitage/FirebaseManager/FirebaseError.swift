//
//  FirebaseError.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 28.04.2021.
//

import Foundation

enum FirebaseError: Error {
    case unableToRegistrateWithFields
    case unableToLogin
    case unableToCreateNonceForAppleSignIn
    case unableToGetAppleIdTokenToSignIn
}

extension FirebaseError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unableToRegistrateWithFields:
            return "It looks like there is problem with filled fields"
            
        case .unableToLogin:
            return "It looks like there is problem with filled fields"
            
        case .unableToCreateNonceForAppleSignIn:
            return "Unable To Create Nonce For Apple Sign In"
        
        case .unableToGetAppleIdTokenToSignIn:
            return "Unable To Get AppleId Token To Sign In"
        }
    }
}
