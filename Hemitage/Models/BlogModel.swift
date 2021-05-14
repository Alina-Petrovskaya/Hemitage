//
//  BlogModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 11.05.2021.
//

import Foundation

class BlogModel: Hashable {
    let uuid = UUID()
    let id: Int
    let imageName: String
    let title: String
    let preview: String
    let date: String
    let text: String
    
    
    init(id: Int,
         imageName: String,
         title: String,
         preview: String,
         date: String,
         text: String) {
        
        self.id        = id
        self.imageName = imageName
        self.title     = title
        self.preview   = preview
        self.date      = date
        self.text      = text
    }
    
    static func == (lhs: BlogModel, rhs: BlogModel) -> Bool {
        return lhs.uuid == rhs.uuid || lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
