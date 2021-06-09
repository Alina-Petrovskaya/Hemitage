//
//  GroupScreenViewModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 31.05.2021.
//

import Foundation

class GroupScreenViewModel: GroupScreenViewModelProtocol {

     enum StateOfNavigationBar {
        case small, large, undefined
    }

    private var categoriesModel: CategoriesModel
    private var stateOfNavigationBar: StateOfNavigationBar = .undefined
    private var contentManager: some ReadContentManagerProtocol = ReadContentManager()
    private var subcategoryList: [GroupScreenSubgroupCellViewModel] = []
    private var songList: [ViewModelTemplateSong] = []
    
    var delegate: GroupScreenViewModelDelegate?
    var selectedSubCategory: String? = nil {
        didSet {
            if selectedSubCategory != nil, oldValue != selectedSubCategory {
                songList.removeAll()
                querySongItems()
            }
        }
    }
    
    init(with categoriesModel: CategoriesModel) {
        self.categoriesModel = categoriesModel
        
        getSubcollectionList(for: categoriesModel.id)
        querySongItems()
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
    
    func querySongItems() {
        let field = selectedSubCategory != nil ? "subCategories" : "categories"
        let value = selectedSubCategory != nil ? selectedSubCategory! : categoriesModel.id!
        
        contentManager.queryItemsFromFirebase(value: value,
                                              field: field,
                                              from: .songs,
                                              with: SongModel.self,
                                              sortField: "raiting",
                                              currentNamberOfItems: songList.count) { [weak self] data in
            
            let items = data.compactMap { model -> ViewModelTemplateSong in
                return ViewModelTemplateSong(songModel: model, isPlaying: false, isHideCloseButton: true)
            }
            
            if self?.songList.count == 0 {
                self?.songList.append(contentsOf: items)
                self?.delegate?.reloadData(section: .songList)
                
            } else {
                self?.songList.append(contentsOf: items)
                self?.delegate?.updateData(items: items, section: .songList, typeOfChange: .added, index: nil)
            }
        }
    }
    
    private func updateItems<T: ViewModelConfigurator & Hashable>(typeOfChange: TypeOfChangeDocument, with item: T, at dataArray: inout [T], section: GroupScreenTypeOfContent) {

        switch typeOfChange {

        case .added:
            dataArray.append(item)
            delegate?.updateData(items: [item], section: section, typeOfChange: .added, index: nil)
            
        case .modified:
            if let index = elementIndex(dataArray: dataArray, newData: item) {
                delegate?.updateData(items: [item], section: section, typeOfChange: .modified, index: index)
            }
            
        case .removed:
            delegate?.updateData(items: [item], section: section, typeOfChange: .removed, index: nil)
            
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
            return songList as? [T]
        }
    }
    
    func newSubcategoryTapped(with index: Int) -> String {
        let data = subcategoryList[index].getData()
        selectedSubCategory = data.id
        
        return data.title
    }
    
}
