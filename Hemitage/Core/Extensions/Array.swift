//
//  Array.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 14.06.2021.
//

import Foundation
import Firebase

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

extension Array where Element == (field: String, value: Any) {
    
    func getQuery(for db: CollectionReference) -> Query? {
        var query: Query? = nil
        
        self.forEach { data in
            if query == nil {
                query = db.whereField(data.field, arrayContains: data.value)
                
            } else {
                query = query?.whereField(data.field, isEqualTo: data.value)
            }
        }
        
        return query
    }
}
