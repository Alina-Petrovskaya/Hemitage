//
//  MainScreenViewModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 11.05.2021.
//

import Foundation
import CoreData

protocol MainScreenViewModelProtocol {
    
    var itemsInserted: (((items: [MainScreenModelWrapper], section: MainScreenTypeOfSection)) -> ())? { get set }
    var itemsReloaded: (((newData: MainScreenModelWrapper, section: MainScreenTypeOfSection, index: Int)) -> ())? { get set }
    var itemsDeleted:  (([MainScreenModelWrapper]) -> ())? { get set }
    
    func getSectionContent(for sectionType: MainScreenTypeOfSection) -> [MainScreenModelWrapper]
    func getItem(for indexPath: IndexPath) -> MainScreenModelWrapper?
}


class MainScreenViewModel: MainScreenViewModelProtocol {
    
    var itemsInserted: (((items: [MainScreenModelWrapper], section: MainScreenTypeOfSection)) -> ())?
    var itemsReloaded: (((newData: MainScreenModelWrapper, section: MainScreenTypeOfSection, index: Int)) -> ())?
    var itemsDeleted: (([MainScreenModelWrapper]) -> ())?
    
    private var categoriesData: [MainScreenModelWrapper] = []
    private var mapData: [MainScreenModelWrapper] = [MainScreenModelWrapper.map(MapCollectionViewCellModelView(allUsers: 15, usersOnline: 5))]
    private var blogData: [MainScreenModelWrapper] = []
    
    private var contentManager = ContentManager()
    private let cacheManager   = ImageCacheManager()
    
    init() {
        manageContent()
    }
    
    
    // MARK: - Manage row content
    private func manageContent() {
        contentManager.callback = { [weak self] result in
            
            switch result.collection {
            
            case .blog:
                guard let data = result.data as? [Article],
                      let self = self
                else { return }
                
                data.forEach { dataItem in
                    
                    if let imageName = dataItem.previewImageName {
                        
                        self.cacheManager.cacheObject(imageName: imageName, documentID: dataItem.id, from: .blog, typeOFUpdate: result.typeOfChange) { data in
                            let item = MainScreenModelWrapper.blog(BlogCollectionViewCellModelView(id: dataItem.id,
                                                                                                   title: dataItem.title,
                                                                                                   subtitle: dataItem.subtitle,
                                                                                                   date: dataItem.date,
                                                                                                   imageData: data.imageData))
                            
                            self.updateItems(typeOfChange: data.typeOfCahnge, with: item, at: &self.blogData, section: .blog)
                        }
                    }
                }
                
                
            case .categories:
                guard let data = result.data as? [CategoriesModel],
                      let self = self
                else { return }
                
                data.forEach { dataItem in
                    guard let safeId = dataItem.id else { return }
                    
                    let viewModel = CategoriesCollectionViewCellModelView(id: safeId, title: dataItem.name, imageURL: dataItem.imageURL)
                    let item = MainScreenModelWrapper.category(viewModel)
                    
                    self.updateItems(typeOfChange: result.typeOfChange,
                                     with: item,
                                     at: &self.categoriesData,
                                     section: .categories)
                }
            }
        }
        
        contentManager.getContent(from: .categories, with: .fireBaseManager)
        contentManager.getContent(from: .blog, with: .coreDataManager)
    }
    
    
    private func updateItems(typeOfChange: TypeOfChangeDocument, with item: MainScreenModelWrapper, at dataArray: inout [MainScreenModelWrapper], section: MainScreenTypeOfSection) {
        
        switch typeOfChange {
        
        case .added:
            dataArray.append(item)
            itemsInserted?((items: [item], section: section))
            
        case .modified:
            if let index = self.getElementIndex(newData: item, currentData: dataArray) {
                self.itemsReloaded?((newData: item, section: section, index: index))
            }
            
        case .removed:
            itemsDeleted?([item])
            
            if let index = dataArray.firstIndex(of: item) {
                dataArray.remove(at: index)
            }
        }
    }
    
    
    private func getElementIndex(newData: MainScreenModelWrapper, currentData: [MainScreenModelWrapper]) -> Int? {
        
        for (index, item) in currentData.enumerated() {
            if item.hashValue == newData.hashValue {
                return index
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

