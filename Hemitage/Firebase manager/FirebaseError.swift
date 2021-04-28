//
//  FirebaseError.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 28.04.2021.
//

import Foundation

enum FirebaseError: Error {
    case unableToRegistrateWithFields
}

extension FirebaseError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .unableToRegistrateWithFields:
            return "It looks like there is problem with filling one of fields"
        }
    }
}
