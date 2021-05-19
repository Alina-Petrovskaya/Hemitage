//
//  BlogCollectionViewCellModelView.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 13.05.2021.
//

import Foundation

protocol BlogCollectionViewCellModelViewProtocol: MainScreenCollectionViewCellModelViewProtocol {
  
    var callBack: (((title: String, subtitle: String, date: String, image: Data?)) -> ())? { get set }
}

class BlogCollectionViewCellModelView: BlogCollectionViewCellModelViewProtocol {
    var callBack: (((title: String, subtitle: String, date: String, image: Data?)) -> ())?
    
    func handleData(with data: MainScreenModelWrapper) {
        switch data {
        case .map(_):
            break
            
        case .category(_):
            break
            
        case .blog(let model):
            break
            //callBack?(model)
        }
    }
}
