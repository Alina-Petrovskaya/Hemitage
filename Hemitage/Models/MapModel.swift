//
//  MapModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 11.05.2021.
//

import Foundation

class MapModel: Hashable {
    let uuid = UUID()
    var allUsers: Int
    var usersOnline: Int
    
    init(allUsers: Int, usersOnline: Int) {
        self.usersOnline = usersOnline
        self.allUsers    = allUsers
    }
    
    static func == (lhs: MapModel, rhs: MapModel) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
