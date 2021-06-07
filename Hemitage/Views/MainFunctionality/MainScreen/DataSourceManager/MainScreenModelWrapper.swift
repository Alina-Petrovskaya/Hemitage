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
            if let newData = viewModel as? BlogCollectionViewCellModelView {
                modelToUpdate.updateContent(with: newData)
            }
            
            
        case .category(let modelToUpdate):
            if let newData = viewModel as? CategoriesCollectionViewCellModelView {
                modelToUpdate.updateContent(with: newData)
            }
            
        case .map(let modelToUpdate):
            if let newData = viewModel as? MapCollectionViewCellModelView {
                modelToUpdate.updateContent(with: newData)
            }
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
        case .blog(let viewModel):
            let data: (id: String, title: String, subtitle: String?, date: String, imageData: Data?) = viewModel.getData()
            return data.id
            
        case .category(let viewModel):
            let data: (id: String, imageURL: URL?, title: String) = viewModel.getData()
            return data.id
            
        case .map(_):
            break
        }
        
        return ""
    }
}
