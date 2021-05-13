//
//  CategoriesCollectionViewCellModelView.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 13.05.2021.
//

import Foundation

protocol CategoriesCollectionViewCellModelViewProtocol: MainScreenCollectionViewCellModelViewProtocol {
    
    var callBack: ((CategoriesModel) -> ())? { get set }
    
}

class CategoriesCollectionViewCellModelView: CategoriesCollectionViewCellModelViewProtocol {
    var callBack: ((CategoriesModel) -> ())?
    
    func handleData(with data: MainScreenModelWrapper) {
        switch data {
        case .map(_):
            break
            
        case .category(let model):
            callBack?(model)
            
        case .blog(_):
            break
        }
    }
    
}
