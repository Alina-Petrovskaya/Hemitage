//
//  MainScreenCollectionViewCellModelView.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 13.05.2021.
//

import Foundation


class MapCollectionViewCellModelView: MainScreenCollectionViewCellModelViewProtocol, Hashable {

    typealias DataType = (allUsers: Int, usersOnline: Int)
    
    private let id = UUID()
    private var allUsers: String
    private var usersOnline: String
    
    init(model: MapModel) {
        self.allUsers    = "\(model.allUsers)"
        self.usersOnline = "\(model.usersOnline)"
    }
    
    func updateContent<T: MainScreenCollectionViewCellModelViewProtocol>(with data: T) -> () {
        guard let data: DataType  = data.getData() else { return }
        
        self.allUsers    = "\(data.allUsers)"
        self.usersOnline = "\(data.usersOnline)"
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

