//
//  CategoriesModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 11.05.2021.
//

import Foundation
import FirebaseFirestoreSwift

struct CategoriesModel: Hashable, Codable, Identifiable {
    @DocumentID var id: String? 
    let imageURL: URL?
    let imageName: String
    let detailImageURL: URL?
    let subTitle: String?
    let name: String
    let isDarkText: Bool
    
    static func ==(lhs: CategoriesModel, rhs: CategoriesModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
