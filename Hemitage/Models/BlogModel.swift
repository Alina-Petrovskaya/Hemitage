//
//  BlogModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 11.05.2021.
//

import Foundation

class BlogModel: Hashable {
    let uuid = UUID()
    let id: String
    let previewImageName: String
    let title: String
    let subtitle: String
    let date: Date
    
    
    init(id: String,
         previewImageName: String,
         title: String,
         subtitle: String,
         date: Date) {
        
        self.id               = id
        self.previewImageName = previewImageName
        self.title            = title
        self.subtitle         = subtitle
        self.date             = date
    }
    
    static func == (lhs: BlogModel, rhs: BlogModel) -> Bool {
        return lhs.uuid == rhs.uuid || lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
