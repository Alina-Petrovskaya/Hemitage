//
//  Array.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 14.06.2021.
//

import Foundation

extension Array where Element: Hashable {
    
    func indexBy(hashvalue: Int) -> Int? {
        for (index, item) in self.enumerated() {
            if item.hashValue == hashvalue {
                return index
            }
        }
        
        return nil
    }
}
