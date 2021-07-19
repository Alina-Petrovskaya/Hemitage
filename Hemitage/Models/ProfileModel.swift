//
//  ProfileModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 11.05.2021.
//

import Foundation
import FirebaseFirestoreSwift

struct ProfileModel: Hashable, Codable, Identifiable {
    
    @DocumentID var id: String?
    let image: URL?
    let name: String
    let subscriptionID: String?
    let subscriptionExpirationDate: Date
    
}
