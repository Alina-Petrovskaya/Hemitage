//
//  CategoriesModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 11.05.2021.
//

import Foundation

class CategoriesModel: Hashable {
    let uuid = UUID()
    let imageName: String
    let name: String
    
    
    init(imageName: String, name: String) {
        self.name      = name
        self.imageName = imageName
    }
    
    static func ==(lhs: CategoriesModel, rhs: CategoriesModel) -> Bool {
        return lhs.uuid == rhs.uuid || lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
