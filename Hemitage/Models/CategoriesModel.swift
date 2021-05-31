//
//  CategoriesModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 11.05.2021.
//

import Foundation
import FirebaseFirestoreSwift

class CategoriesModel: Hashable, Codable, Identifiable {
    @DocumentID var id: String? 
    var imageURL: URL?
    var imageName: String
    var name: String
    
    init(imageURL: URL?, imageName: String, name: String) {
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
