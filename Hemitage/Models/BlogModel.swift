//
//  BlogModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 11.05.2021.
//

import Foundation
import FirebaseFirestoreSwift

struct BlogModel: Hashable, Codable, Identifiable {
    @DocumentID var id: String?
    let previewImageName: String
    let title: String
    let subtitle: String
    let date: Date
    
    static func == (lhs: BlogModel, rhs: BlogModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
