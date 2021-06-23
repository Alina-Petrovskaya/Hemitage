//
//  MapModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 11.05.2021.
//

import Foundation

struct MapModel: Hashable {
    let uuid = UUID()
    let allUsers: Int
    let usersOnline: Int
    
    static func == (lhs: MapModel, rhs: MapModel) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
