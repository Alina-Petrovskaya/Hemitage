//
//  IAPError.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 25.06.2021.
//

import Foundation

enum IAPError: Error {
    case alreadySubscribed
    
    func getErrorDescription(date: Date? = nil) -> String? {
        switch self {
        
        case .alreadySubscribed:
            var error = "This subscription has already been subscribed"
            error += date != nil ? " Valid until \(date!.stringRepresentation())" : ""
            
            return error
        }
    }
}
