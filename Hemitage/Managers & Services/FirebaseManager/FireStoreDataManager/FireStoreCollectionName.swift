//
//  FireStoreCollectionName.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 17.05.2021.
//

import Foundation

enum FireStoreCollectionName: String {
    case blog = "Blog"
    case categories = "Categories"
    

    func getSubcollectionName() -> String? {
        switch self {
        
        case .categories:
            return "subGroup"
        
        default:
            break
        }
        
        return nil
    }
}
