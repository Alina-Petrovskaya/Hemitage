//
//  MainScreenCollectionViewCellModelView.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 13.05.2021.
//

import Foundation

protocol MapCollectionViewCellModelViewProtocol: MainScreenCollectionViewCellModelViewProtocol {
   
    var callBack: (((allUsers: String, usersOnline: String)) -> ())? { get set }
    
}


class MapCollectionViewCellModelView: MapCollectionViewCellModelViewProtocol {

    var callBack: (((allUsers: String, usersOnline: String)) -> ())?
    
    func handleData(with data: MainScreenModelWrapper) {
        switch data {
        case .map(let model):
            let allUsers = "\(model.allUsers)K"
            let usersOnline = "\(model.usersOnline)K"
            
            callBack?((allUsers: allUsers, usersOnline: usersOnline))
            
        case .category(_):
            break
            
        case .blog(_):
            break
        }
    }
}

