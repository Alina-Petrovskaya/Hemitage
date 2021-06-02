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
    let imageURL: URL?
    let imageName: String
    let detailImageURL: URL?
    let subTitle: String?
    let name: String
    let isDarkText: Bool
    
    init(imageURL: URL?,
         imageName: String,
         name: String,
         detailImageURL: URL?,
         subTitle: String?,
         isDarkText: Bool) {
        
        self.name           = name
        self.imageURL       = imageURL
        self.imageName      = imageName
        self.detailImageURL = detailImageURL
        self.subTitle       = subTitle
        self.isDarkText     = isDarkText
    }
    
    static func ==(lhs: CategoriesModel, rhs: CategoriesModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
