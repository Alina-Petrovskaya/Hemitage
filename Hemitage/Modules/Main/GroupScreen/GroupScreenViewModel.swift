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
                songManager.premiumMusic.removeAll()
                querySongItems(section: songManager.currentSongSection)
            }
        }
    }
    
    init(with categoriesModel: CategoriesModel) {
        self.categoriesModel = categoriesModel
        manageSubcollections(for: categoriesModel.id)
        manageMusicCallback()
        
        contentManager.getContent(from: .products, with: .fireBaseManager, codableModel: PaymentModel.self)
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
        
        let numberOfItems = section == .songList ? songManager.songList.count : songManager.premiumMusic.count
        let serchingData: [(field: String, value: Any)] =  [
            (field: "subCategories", value: documentID),
            (field: "isPremium", value: section == .premiumContent)
        ]
        
        contentManager.queryItemsFromFirebase(fieldsToSerchBy: serchingData,
                                              from: .songs,
                                              with: SongModel.self,
                                              sortField: "raiting",
                                              currentNumberOfItems: numberOfItems) { [weak self] data in
            
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
    
    
    func handleInteraction(interactionType: GroupScreenCellsTypeOfInteraction,
                           completion: (((viewModel: ViewModelTemplateSongProtocol?, isNeedToByeMore: Bool)) -> ())? = nil) {
        
        let isCanPlay       = songManager.status.isCanPlayMusic()
        let isNeedToByeMore = songManager.status.isNeedToByeContent()
        
        switch interactionType {
        
        case .reload(let index, let section):
            if section == .subGroup {
                selectedSubCategory = subcategoryList[index].getID()
            } else {
                songManager.currentSongSection = section
                songManager.songList.removeAll()
                songManager.premiumMusic.removeAll()
                querySongItems(section: section)
            }
            
        case .save(let index, let section, let isCanPlay):
            if isCanPlay {
                songManager.currentSongSection = section
                songManager.manageSongSaving(index: index, section: section)
            } else {
                completion?((viewModel: nil, isNeedToByeMore: true))
            }
            
            
        case .requestForMoreItems(let section):
            songManager.currentSongSection = section
            querySongItems(section: section)
            
        case .play(let index, let section, let isCanPlay):
        if isCanPlay {
            songManager.currentSongSection = section
            songManager.playSong(at: index, section)
        } else if !isCanPlay, isNeedToByeMore {
            completion?((viewModel: nil, isNeedToByeMore: true))
        }
            
        case .showDetail(let index, let section):
            songManager.currentSongSection = section
            let model = section == .songList ? songManager.songList[index] : songManager.premiumMusic[index]
            
            completion?((viewModel: model, isNeedToByeMore: isNeedToByeMore && !isCanPlay))
            
        }
    }
    
    
    func isPremiumContenHidden() -> Bool {
     return songManager.status.isPremiumContentHidden()
    }
    
}
