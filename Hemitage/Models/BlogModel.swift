//
//  BlogModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 11.05.2021.
//

import Foundation

struct BlogModel: Hashable {
    let uuid = UUID()
    let imageName: String
    let title: String
    let preview: String
    let date: String
    let text: String
    
    static func == (lhs: BlogModel, rhs: BlogModel) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
