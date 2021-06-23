//
//  PaymentModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 22.06.2021.
//

import Foundation
import FirebaseFirestoreSwift

struct PaymentModel: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    let title: String
    let description: String
    let price: Double
    let image: String
}
