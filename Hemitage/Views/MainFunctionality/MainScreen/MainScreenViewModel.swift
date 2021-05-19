//
//  MainScreenViewModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 11.05.2021.
//

import Foundation


protocol MainScreenViewModelProtocol {
    
    var itemsInserted: (((items: [MainScreenModelWrapper], section: MainScreenTypeOfSection)) -> ())? { get set }
    var itemsReloaded: (((newData: AnyHashable, section: MainScreenTypeOfSection, index: Int)) -> ())? { get set }
    var itemsDeleted:  (([MainScreenModelWrapper]) -> ())? { get set }
    
    func getSectionContent(for sectionType: MainScreenTypeOfSection) -> [MainScreenModelWrapper]
    func getItem(for indexPath: IndexPath) -> MainScreenModelWrapper?
}


class MainScreenViewModel: MainScreenViewModelProtocol {
    
    var itemsInserted: (((items: [MainScreenModelWrapper], section: MainScreenTypeOfSection)) -> ())?
    var itemsReloaded: (((newData: AnyHashable, section: MainScreenTypeOfSection, index: Int)) -> ())?
    var itemsDeleted: (([MainScreenModelWrapper]) -> ())?
    
    var dataManager: some FireStoreDataManagerProtocol = FireStoreCacheDataManager()
    
    private var categoriesData: [MainScreenModelWrapper] = []
    private var mapData: [MainScreenModelWrapper] = [MainScreenModelWrapper.map(MapModel(allUsers: 15, usersOnline: 5))]
    private var blogData: [MainScreenModelWrapper] = []
    
    
    init() {
        manageContent()
    }
    
    
    private func manageContent() {
        dataManager.callBack = { [weak self] result in
            
            switch result.collection {
            case .blog:
            break
              
                
            case .categories:
                guard let data = result.data as? CategoriesModel else { return }
                let item = MainScreenModelWrapper.category(data)
                
                switch result.typeOfChange {
                case .added:
                    self?.categoriesData.append(item)
                    self?.itemsInserted?((items: [item], section: .categories))
                    
                case .modified:
                    if let index = self?.getElementIndex(newData: item, section: .categories) {
                        self?.itemsReloaded?((newData: data, section: .categories, index: index))
                    }
                    
                case .removed:
                    self?.itemsDeleted?([item])
                    if let index = self?.categoriesData.firstIndex(of: item) {
                        self?.categoriesData.remove(at: index)
                    }
                }
            }
        }
        dataManager.fetchData(from: .categories)
    }
    
    
        private func getElementIndex(newData: MainScreenModelWrapper, section: MainScreenTypeOfSection) -> Int? {
            
            switch section {
            
            case .map:
                break
            case .categories:
                for (index, item) in categoriesData.enumerated() {
                    if item.hashValue == newData.hashValue {
                        return index
                    }
                }
                
            case .blog:
                for (index, item) in blogData.enumerated() {
                    if item.hashValue == newData.hashValue {
                        return index
                    }
                }
            }
        
        return nil
    }
    
    
    // Actions
    func getSectionContent(for sectionType: MainScreenTypeOfSection) -> [MainScreenModelWrapper] {
        switch sectionType {
        case .map:
            return mapData
            
        case .categories:
            return categoriesData
            
        case .blog:
            return blogData
        }
    }
    
    
    func getItem(for indexPath: IndexPath) -> MainScreenModelWrapper? {
        guard let section = MainScreenTypeOfSection(rawValue: indexPath.section) else { return nil }
        
        switch section {
        case .map:
            return mapData[indexPath.row]
            
        case .categories:
            return categoriesData[indexPath.row]
            
        case .blog:
            return blogData[indexPath.row]
        }
    }
}

