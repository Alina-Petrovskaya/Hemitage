//
//  SubcollectionModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 01.06.2021.
//

import Foundation
import FirebaseFirestoreSwift

class SubcollectionModel: Hashable, Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    
    
    static func == (lhs: SubcollectionModel, rhs: SubcollectionModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
