//
//  Date.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 19.05.2021.
//

import Foundation

extension Date {
    
    func stringRepresentation() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "d. mm. yyyy"
        return dateFormatter.string(from: self)
    }
}
