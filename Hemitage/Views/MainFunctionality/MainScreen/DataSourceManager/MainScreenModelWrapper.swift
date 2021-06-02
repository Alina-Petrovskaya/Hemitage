//
//  MainScreenModelWrapper.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 11.05.2021.
//

import Foundation

enum MainScreenModelWrapper: Hashable {
    case map(MapCollectionViewCellModelView)
    case category(CategoriesCollectionViewCellModelView)
    case blog(BlogCollectionViewCellModelView)
    
    
    /**
     Replace current data with new data from model
     */
    func setData(with model: MainScreenModelWrapper) {
        let viewModel = model.getViewModel()
        
        switch self {
        case .blog(let modelToUpdate):
            let data: (title: String, subtitle: String?, date: String, imageData: Data?) = viewModel.getData()
            modelToUpdate.updateContent(with: data)
            
        case .category(let modelToUpdate):
            let data: (id: String, imageURL: URL?, title: String) = viewModel.getData()
            modelToUpdate.updateContent(with: data)
            
        case .map(let modelToUpdate):
            let data: (allUsers: String, usersOnline: String) = viewModel.getData()
            modelToUpdate.updateContent(with: data)
        }
    }
    
    /**
     Return current data of type MainScreenCollectionViewCellModelViewProtocol
     */
    func getViewModel() -> MainScreenCollectionViewCellModelViewProtocol {
        switch self {
        case .blog(let viewModel):
            return viewModel
            
        case .category(let viewModel):
            return viewModel
            
        case .map(let viewModel):
            return viewModel
        }
    }
    
    
    func getItemId() -> String {
        switch self {
        case .blog(_):
            break
            
        case .category(let viewModel):
            let data: (id: String, imageURL: URL?, title: String) = viewModel.getData()
            return data.id
            
        case .map(_):
            break
        }
        
        return ""
    }
}
