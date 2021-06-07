//
//  GroupScreenViewModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 31.05.2021.
//

import Foundation

enum GroupScreenTypeOfContent {
   case navigationBar
   case subGroup
   case songList
}

protocol GroupScreenViewModelDelegate {
    
    func itemsInserted<T: ViewModelConfigurator>(items: [T], section: GroupScreenTypeOfContent)
    func itemsReloaded<T: ViewModelConfigurator>(newData: T, section: GroupScreenTypeOfContent, index: Int)
    func itemsDeleted<T: ViewModelConfigurator>(items: [T], section: GroupScreenTypeOfContent)
    
}

protocol GroupScreenViewModelProtocol {
    var delegate: GroupScreenViewModelDelegate? { get set }
    
    func heightNavBarHandling(height: Double?, completion: () -> ())
    func getDataContent<T: ViewModelConfigurator>(for contentType: GroupScreenTypeOfContent) -> [T]?
}

class GroupScreenViewModel: GroupScreenViewModelProtocol {
    
     enum StateOfNavigationBar {
        case small, large, undefined
    }
    
    var delegate: GroupScreenViewModelDelegate?
    private var categoriesModel: CategoriesModel
    private var stateOfNavigationBar: StateOfNavigationBar = .undefined
    private var contentManager: some ContentManagerProtocol = ContentManager()
    private var subcategoryList: [GroupScreenSubgroupCellViewModel] = []
    
    
    init(with categoriesModel: CategoriesModel) {
        self.categoriesModel = categoriesModel
        
        getSubcollectionList(for: categoriesModel.id)
    }
 
    // MARK: - Manage Content
    private func getSubcollectionList(for id: String?) {
        contentManager.callback = { [weak self] result in
            guard let data = result.data as? [SubcollectionModel] else { return }
            
            data.forEach { model in
                guard let id = model.id,
                      let self = self else { return }
                
                let item = GroupScreenSubgroupCellViewModel(with: (id: id, title: model.name))
                self.updateItems(typeOfChange: result.typeOfChange, with: item, at: &self.subcategoryList, section: .subGroup)
            }
        }
        
        
        if let documentId = categoriesModel.id {
            contentManager.getItemsFromSubgroup(from: .categories, with: SubcollectionModel.self, document: documentId)
        }
    }
    
    
    private func getSongItems() {
        
        
    }
    
    
    private func updateItems<T: ViewModelConfigurator & Hashable>(typeOfChange: TypeOfChangeDocument, with item: T, at dataArray: inout [T], section: GroupScreenTypeOfContent) {

        switch typeOfChange {

        case .added:
            dataArray.append(item)
            delegate?.itemsInserted(items: [item], section: section)

        case .modified:
            if let index = elementIndex(dataArray: dataArray, newData: item) {
                delegate?.itemsReloaded(newData: item, section: section, index: index)
            }

        case .removed:
            delegate?.itemsDeleted(items: [item], section: section)
            if let index = elementIndex(dataArray: dataArray, newData: item) {
                dataArray.remove(at: index)
            }
        }
    }
    
    private func elementIndex<T: ViewModelConfigurator & Hashable>(dataArray: [T], newData: T) -> Int? {
        for (index, item) in dataArray.enumerated() {
            if item.hashValue == newData.hashValue {
                return index
            }
        }
        return nil
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
    func getDataContent<T: ViewModelConfigurator>(for contentType: GroupScreenTypeOfContent) -> [T]? {
        switch contentType {
    
        case .navigationBar:
            let navigationViewModel: some ViewModelConfigurator = GroupNavigationViewModel(with: (title: categoriesModel.name,
                                                                                           imageURL: categoriesModel.detailImageURL,
                                                                                           subtitle: categoriesModel.subTitle,
                                                                                           isDarkText: categoriesModel.isDarkText))
            return [navigationViewModel] as? [T]
           
            
        case .subGroup:
            return subcategoryList as? [T]
            
            
        case .songList:
            break
        }
        
        return nil
    }
    
}
