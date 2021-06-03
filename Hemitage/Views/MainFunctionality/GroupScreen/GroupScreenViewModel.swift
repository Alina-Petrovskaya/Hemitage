//
//  GroupScreenViewModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 31.05.2021.
//

import Foundation

protocol GroupScreenViewModelProtocol {
    associatedtype TypeOfContent
    
    func heightNavBarHandling(height: Double?, completion: () -> ())
    func getDataContent<T: ViewModelConfigurator>(for contentType: TypeOfContent) -> T?
    
}

class GroupScreenViewModel {
    
     enum StateOfNavigationBar {
        case small, large, undefined
    }
    
     enum GroupScreenTypeOfContent {
        case navigationBar
        case subGroup
        case songList
    }
    
    private var categoriesModel: CategoriesModel
    private var stateOfNavigationBar: StateOfNavigationBar = .undefined
//    private var contentManager: 
    
    
    init(with categoriesModel: CategoriesModel) {
        self.categoriesModel = categoriesModel
        
        getSubcollectionList(for: categoriesModel.id)
    }
 
    // MARK: - Manage Content
    
    private func getSubcollectionList(for id: String?) {
        
    }
    
    
    // MARK: - Manage Navigation Bar
    func heightNavBarHandling(height: Double?, completion: () -> ()) {
        guard let safeHeight = height else { return }
        let currentTypeOfNavBar = determinationOfNavBarStatus(with: safeHeight)
        
        switch stateOfNavigationBar {
        
        case .undefined:
            stateOfNavigationBar = currentTypeOfNavBar
            
        default:
            if stateOfNavigationBar != currentTypeOfNavBar {
                completion()
                stateOfNavigationBar = currentTypeOfNavBar
            }
        }
    }
    
    
    private func determinationOfNavBarStatus(with height: Double) -> StateOfNavigationBar {
        if height > 120 {
            return .large
        } else {
            return .small
        }
    }
    
    
    // MARK: - Actions
    func getDataContent<T: ViewModelConfigurator>(for contentType: GroupScreenTypeOfContent) -> T? {
        switch contentType {
    
        case .navigationBar:
            let navigationViewModel: some ViewModelConfigurator = GroupNavigationViewModel(with: (title: categoriesModel.name,
                                                                                           imageURL: categoriesModel.detailImageURL,
                                                                                           subtitle: categoriesModel.subTitle,
                                                                                           isDarkText: categoriesModel.isDarkText))
            return navigationViewModel as? T
           
            
        case .subGroup:
            break
            
        case .songList:
            break
        }
        
        return nil
    }
    
}
