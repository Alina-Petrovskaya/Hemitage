//
//  CategoriesModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 11.05.2021.
//

import Foundation

class CategoriesModel: Hashable, Codable {
    var id: String
    var imageURL: URL?
    var imageName: String
    var name: String
    
    init(id: String, imageURL: URL?, imageName: String, name: String) {
        self.id        = id
        self.name      = name
        self.imageURL  = imageURL
        self.imageName = imageName
    }
    
    static func ==(lhs: CategoriesModel, rhs: CategoriesModel) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
