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
}

extension FirebaseError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unableToRegistrateWithFields:
            return "It looks like there is problem with filled fields"
            
        case .unableToLogin:
            return "It looks like there is problem with filled fields"
        }
    }
}
