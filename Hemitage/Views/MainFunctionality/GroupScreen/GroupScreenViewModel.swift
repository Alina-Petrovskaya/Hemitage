//
//  GroupScreenViewModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 31.05.2021.
//

import Foundation

class GroupScreenViewModel {
    
    private enum StateOfNavigationBar {
        case small, large, undefined
    }
    
    private enum GroupScreenTypeOfContent {
        case navigationBar
        case subGroup
        case songList
    }
    
    private var categoriesModel: CategoriesModel
    private var stateOfNavigationBar: StateOfNavigationBar = .undefined
    
    
    init(with categoriesModel: CategoriesModel) {
        self.categoriesModel = categoriesModel
    }
    
    
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
        if height > 44.0 {
            return .large
        } else {
            return .small
        }
    }
   
    
    
    // MARK: - Actions
    private func getData<T: ViewModelConfigurator>(for contentType: GroupScreenTypeOfContent) -> T? {
        switch contentType {
        
        case .navigationBar:
            let navigationViewModel: some ViewModelConfigurator = GroupNavigationViewModel(title: categoriesModel.name, imageURL: nil, subtitle: nil)
            return navigationViewModel as? T
            
        case .subGroup:
            break
            
        case .songList:
            break
        }
        
        return nil
    }
    
}
