//
//  MainScreenTypeOfSection.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 11.05.2021.
//

import Foundation


enum MainScreenTypeOfSection: Int, CaseIterable {
    case map, categories, blog
    
    var columnCount: Int {
        switch self {
        case .map:
            return 1
        case .categories:
            return 2
        case .blog:
            return 1
        }
    }
}
