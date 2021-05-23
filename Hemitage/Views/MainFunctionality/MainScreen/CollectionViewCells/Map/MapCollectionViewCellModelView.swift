//
//  MainScreenCollectionViewCellModelView.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 13.05.2021.
//

import Foundation


class MapCollectionViewCellModelView: MainScreenCollectionViewCellModelViewProtocol, Hashable {

    private let id = UUID()
    private var allUsers: String
    private var usersOnline: String
    
    init(allUsers: Int, usersOnline: Int) {
        self.allUsers    = "\(allUsers)"
        self.usersOnline = "\(usersOnline)"
    }
    
    func updateContent<T>(with data: T) -> () {
        guard let safeData = data as? (allUsers: String, usersOnline: String) else { return }
        
        self.allUsers    = safeData.allUsers
        self.usersOnline = safeData.usersOnline
    }
    
    func getData<T>() -> T {
        guard let data = (allUsers: allUsers, usersOnline: usersOnline) as? T else {
            fatalError()
        }
        return data
    }

    
    static func == (lhs: MapCollectionViewCellModelView, rhs: MapCollectionViewCellModelView) -> Bool {
        return lhs.id == rhs.id
            && lhs.allUsers == rhs.allUsers
            && lhs.usersOnline == rhs.usersOnline
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

