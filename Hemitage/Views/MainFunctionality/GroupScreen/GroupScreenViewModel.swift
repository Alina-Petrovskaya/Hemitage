//
//  GroupScreenViewModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 31.05.2021.
//

import Foundation

class GroupScreenViewModel: GroupScreenViewModelProtocol {
    
    private var categoriesModel: CategoriesModel
    private var contentManager: some ReadContentManagerProtocol = ReadContentManager()
    private var subcategoryList: [GroupScreenSubgroupCellViewModel] = []
    private let songManager = GroupScreenSongManager()
    
    var delegate: GroupScreenViewModelDelegate?
    var selectedSubCategory: String? = nil {
        didSet {
            if selectedSubCategory != nil, oldValue != selectedSubCategory {
                songManager.songList.removeAll()
                querySongItems(section: songManager.currentSongSection)
            }
        }
    }
    
    init(with categoriesModel: CategoriesModel) {
        self.categoriesModel = categoriesModel
        manageSubcollections(for: categoriesModel.id)
        manageMusicCallback()

    }
 
    // MARK: - Manage Content
    private func manageMusicCallback() {
        songManager.callBack = { [weak self] data in
            guard let items = data.items as? [ViewModelTemplateSong]  else { return }
            self?.delegate?.updateData(items: items, section: data.section, typeOfChange: data.typeOfChange, index: data.index)
        }
        
        songManager.reloadData = { [weak self] in
            guard let self = self else { return }
            self.querySongItems(section: self.songManager.currentSongSection)
        }
    
    }
    
    private func manageSubcollections(for collectionID: String?) {
        contentManager.callback = { [weak self] result in
            
            guard let data = result.data as? [SubcollectionModel], let self = self else { return }
            
            let items = data.compactMap { model -> GroupScreenSubgroupCellViewModel? in
                guard let id = model.id else { return nil }
                return GroupScreenSubgroupCellViewModel(with: (id: id, title: model.name))
            }
            
            switch result.typeOfChange {
            
            case .added:
                if self.subcategoryList.isEmpty {
                    self.subcategoryList = items
                    self.delegate?.reloadData(section: .subGroup)
                    self.selectedSubCategory = items[0].getID()
                    
                } else {
                    self.subcategoryList.append(contentsOf: items)
                    self.delegate?.updateData(items: items, section: .subGroup, typeOfChange: .added, index: nil)
                }
                
            case .modified:
                if let index = self.subcategoryList.indexBy(hashvalue: items[0].hashValue) {
                    self.delegate?.updateData(items: items, section: .subGroup , typeOfChange: .modified, index: index)
                }
                
            case .removed:
                if let index = self.subcategoryList.indexBy(hashvalue: items[0].hashValue) {
                    self.delegate?.updateData(items: items, section: .subGroup , typeOfChange: .removed, index: index)
                    self.subcategoryList.remove(at: index)
                }
            }
        }

        if let documentId = categoriesModel.id {
            contentManager.getItemsFromSubgroup(from: .categories, with: SubcollectionModel.self, document: documentId)
        }
    }
    
    
   private func querySongItems(section: GroupScreenTypeOfContent = .songList) {
        guard let documentID = selectedSubCategory else { return }
    
        contentManager.queryItemsFromFirebase(value: documentID, field: "subCategories", from: .songs, with: SongModel.self, sortField: "raiting",
                                              currentNamberOfItems: songManager.songList.count) { [weak self] data in
            
            guard let songData = self?.songManager.addSongs(songs: data) else { return }
            
            if songData.isNeedReload {
                self?.delegate?.reloadData(section: section)
            } else {
                self?.delegate?.updateData(items: songData.songs, section: .songList, typeOfChange: .added, index: nil)
            }
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
            return songManager.songList as? [T]
            
        case .premiumContent:
            return songManager.premiumMusic as? [T]
        }
    }
    
    
    func handleInteraction(interactionType: SongTemplateTypeOfInteraction, completion: ((ViewModelTemplateSongProtocol) -> ())? = nil) {
        switch interactionType {
        
        case .reload(let index, let section):
            if section == .subGroup {
                selectedSubCategory = subcategoryList[index].getID()
            } else {
                songManager.currentSongSection = section
                delegate?.reloadData(section: section)
            }
            
        case .save(let index, let section):
            songManager.currentSongSection = section
            songManager.manageSongSaving(index: index, section: section)
            
        case .requestForMoreItems(let section):
            songManager.currentSongSection = section
            querySongItems(section: section)
        
        case .play(let index, let section):
            songManager.currentSongSection = section
            songManager.playSong(at: index, section)
        
            
        case .showDetail(let index, let section):
            if section == .songList {
                songManager.currentSongSection = section
                completion?(songManager.songList[index])
            } else {
                completion?(songManager.premiumMusic[index])
            }
        }
    }
    
    
    func isPremiumContenHidden() -> Bool {
     return songManager.status.isPremiumContentHidden()
    }
    
}
