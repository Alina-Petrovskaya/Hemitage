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
    var songChanged:   (((data: TemplateSongView.DataType, isHidden: Bool)) -> ())? { get set }
    
    func getSectionContent(for sectionType: MainScreenTypeOfSection) -> [MainScreenModelWrapper]
    func changePlayerState(action: MainScreenSongManagering)
    func getUserData(completion: @escaping (ViewModelTemplateHeader) -> ())
    func manageCollectionActions(with delegate: MainScreenCollectionViewDelegate?,
                                 completion: @escaping ((model: AnyHashable, section: MainScreenTypeOfSection)) -> ())
}


class MainScreenViewModel: MainScreenViewModelProtocol, PlayerObserver {
    
    var itemsInserted: (((items: [MainScreenModelWrapper], section: MainScreenTypeOfSection)) -> ())?
    var itemsReloaded: (((newData: MainScreenModelWrapper, section: MainScreenTypeOfSection, index: Int)) -> ())?
    var itemsDeleted: (([MainScreenModelWrapper]) -> ())?
    var songChanged:  (((data: TemplateSongView.DataType, isHidden: Bool) )-> ())?
    var songData: TemplateSongView.DataType?
    
    private var categoriesData: [MainScreenModelWrapper] = []
    private var mapData: [MainScreenModelWrapper] = [MainScreenModelWrapper.map(MapCollectionViewCellModelView(model: MapModel(allUsers: 15, usersOnline: 5)))]
    private var blogData: [MainScreenModelWrapper] = []
    private var contentManager: ReadContentManagerProtocol = ReadContentManager()
    private let cacheManager   = CacheManager()
    private let userManager: FireStoreUserManagerProtocol = FireStoreUserManager()
    
    
    init() {
        manageContent()
        PlayerManager.shared.subscribe(self)
    }
    
    deinit {
        PlayerManager.shared.unSubscribe(self)
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
                        
                        self.cacheManager.cacheImageObject(imageName: imageName, documentID: dataItem.id, from: .blog, typeOFUpdate: result.typeOfChange) { data in
                            let item = MainScreenModelWrapper.blog(BlogCollectionViewCellModelView(model: dataItem, imageData: data.imageData))
                            self.updateItems(typeOfChange: data.typeOfCahnge, with: item, at: &self.blogData, section: .blog)
                        }
                    }
                }
                
                
            case .categories:
                guard let data = result.data as? [CategoriesModel],
                      let self = self
                else { return }
                
                data.forEach { dataItem in
                    
                    let viewModel = CategoriesCollectionViewCellModelView(model: dataItem)
                    let item = MainScreenModelWrapper.category(viewModel)
                    
                    self.updateItems(typeOfChange: result.typeOfChange,
                                     with: item,
                                     at: &self.categoriesData,
                                     section: .categories)
                }
            
            default:
                break
            }
        }
        
        contentManager.getContent(from: .categories, with: .fireBaseManager, codableModel: CategoriesModel.self)
        contentManager.getContent(from: .blog, with: .coreDataManager, codableModel: BlogModel.self)
    }
    
    
    private func updateItems(typeOfChange: TypeOfChangeDocument, with item: MainScreenModelWrapper, at dataArray: inout [MainScreenModelWrapper], section: MainScreenTypeOfSection) {
        
        switch typeOfChange {
        
        case .added:
            dataArray.append(item)
            itemsInserted?((items: [item], section: section))
            
        case .modified:
            if let index = dataArray.indexBy(hashvalue: item.hashValue) {
                self.itemsReloaded?((newData: item, section: section, index: index))
            }
            
        case .removed:
            itemsDeleted?([item])
            
            if let index = dataArray.indexBy(hashvalue: item.hashValue) {
                dataArray.remove(at: index)
            }
        }
    }
    
    
    // MARK: - Actions
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
    

    func manageCollectionActions(with delegate: MainScreenCollectionViewDelegate?,
                                 completion: @escaping ((model: AnyHashable, section: MainScreenTypeOfSection)) -> ()) {
        delegate?.callBack = { [weak self] indexPath in
            
            
            guard let section = MainScreenTypeOfSection(rawValue: indexPath.section),
                  let self = self else { return }
            
            switch section {
            case .map:
                break
                
            case .categories:
                delegate?.callBack = nil
                self.contentManager.getDocumentFromFirebase(id: self.categoriesData[indexPath.row].getItemId(),
                                                             from: .categories,
                                                             model: CategoriesModel.self) { completion((model: $0[0], section: .categories)) }
                
            case .blog:
                break
            }
        }
    }
    
    
    func getUserData(completion: @escaping (ViewModelTemplateHeader) -> ()) {
        userManager.getUserData { model in
            
            completion(ViewModelTemplateHeader(model: model))
            
        }
    }
    
    // MARK: - Player manager
    func playerStateChanged(isPlaying: Bool, currentSong: ViewModelTemplateSongProtocol?, previousSong: ViewModelTemplateSongProtocol?) {
        guard let song = currentSong as? ViewModelTemplateSong  else { return }
        song.updatePlayingState(isPlay: isPlaying)
        songChanged?((data: song.getData(), isHidden: !isPlaying))
    }
    
    
    func changePlayerState(action: MainScreenSongManagering) {
      
        switch action {
        case .play:
            PlayerManager.shared.pause()
            
        case .stop:
            PlayerManager.shared.stopSong()
        }
    }
    
    
}

