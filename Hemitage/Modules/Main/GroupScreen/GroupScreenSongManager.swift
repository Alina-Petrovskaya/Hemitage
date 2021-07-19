//
//  GroupScreenSongManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 11.06.2021.
//

import Foundation
import Network

class GroupScreenSongManager: PlayerObserver {
    
    var reloadData: (() -> ())?
    var songList: [ViewModelTemplateSongProtocol] = []
    var premiumMusic: [ViewModelTemplateSongProtocol] = []
    var callBack: ( ((items: [ViewModelTemplateSongProtocol], section: GroupScreenTypeOfContent, typeOfChange: TypeOfChangeDocument, index: Int?)) -> () )?
    var currentSongSection: GroupScreenTypeOfContent = .songList
    var status: SubscriptionAndNetworkStatus = .unowned
    
    private let monitor = NWPathMonitor()
    private let cacheManager = CacheManager()
    private var canPlaySong: Bool = true
    private var networkstatus: NWPath.Status = .requiresConnection
    
    
    init() {
        monitorNetwork()
        canPlaySong = status.isCanPlayMusic()
        manageDataMusic()
        
        PlayerManager.shared.subscribe(self)
    }
    
    
    deinit {
        PlayerManager.shared.unSubscribe(self)
    }
    
    private func monitorNetwork() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.networkstatus = path.status
            
            if path.status == .satisfied {
                self?.status = .noNetworkNoSubscription
                
            } else {
                self?.status = .noNetworkNoSubscription
            }
            
            self?.songList.removeAll()
            self?.premiumMusic.removeAll()
            self?.reloadData?()
        }
        
        let queue = DispatchQueue.global()
        monitor.start(queue: queue)
    }
    
    // MARK: - Configure Content
    func addSongs(songs: [SongModel]) -> (songs: [ViewModelTemplateSong], isNeedReload: Bool) {
        let currentSongID = PlayerManager.shared.getIdOfPlayingSong()
        
        let items = songs.compactMap { model -> ViewModelTemplateSong? in
            guard let id = model.id else { return nil }
            
            let isSaved = cacheManager.isSongSaved(docimentID: id)
            let isCanPlay = networkstatus == .satisfied
                ? true
                : status.isCanPlayMusic() && isSaved
            
            return ViewModelTemplateSong(songModel: model,
                                         isPlaying: currentSongID == model.id,
                                         isHideCloseButton: true,
                                         isCanPlay: isCanPlay,
                                         isSaved: isSaved)
        }
        
        let needToReload = currentSongSection == .songList
            ? songList.count == 0
            : premiumMusic.count == 0
        
        if currentSongSection == .songList {
            songList.append(contentsOf: items)
        } else {
            premiumMusic.append(contentsOf: items)
        }
        
        return (songs: items, isNeedReload: needToReload)
    }
    
    
    func manageSongSaving(index: Int, section: GroupScreenTypeOfContent) {
        let songModel = (section == .songList) ? songList[index] : premiumMusic[index]
        
        guard let songURL = songModel.getSongData().songURL else { return }
        let id = songModel.getSongData().id
       
        cacheManager.manageSongSaving(songURL: songURL, documentID: id) { [weak self] isSaved in
            songModel.updateSavingState(isSaved: isSaved)
            self?.callBack?((items: [songModel], section: .songList, typeOfChange: .modified, index: index))
        }
    }
    
    
    // MARK: - Music control
    func playSong(at index: Int, _ section: GroupScreenTypeOfContent) {
        PlayerManager.shared.configureSongList(with: section == .songList ? songList : premiumMusic)
        PlayerManager.shared.playSong(at: index)
    }
    
    
    private func manageDataMusic() {
        PlayerManager.shared.callForSongData = { [weak self] dataFromPlayer in
            
            self?.cacheManager.cacheSongObject(songURL: dataFromPlayer.url, documentID: dataFromPlayer.id) { result in
                switch result {
                case .success(let data):
                    PlayerManager.shared.playSong(with: data)
                    
                case .failure(_):
                    PlayerManager.shared.playSong(at: dataFromPlayer.index + 1)
                }
            }
        }
    }
    
    
    func playerStateChanged(isPlaying: Bool, currentSong: ViewModelTemplateSongProtocol?, previousSong: ViewModelTemplateSongProtocol?) {
        
        if currentSong != nil {
            currentSong?.updatePlayingState(isPlay: isPlaying)
            
            let index = currentSongSection == .songList
                ? modifireSong(at: &songList, newItem: currentSong!)
                : modifireSong(at: &premiumMusic, newItem: currentSong!)
            
            callBack?((items: [currentSong!], section: .songList, typeOfChange: .modified, index: index))
            
        }
        if previousSong != nil {
            previousSong?.updatePlayingState(isPlay: false)
            
            let index = currentSongSection == .songList
                ? modifireSong(at: &songList, newItem: previousSong!)
                : modifireSong(at: &premiumMusic, newItem: previousSong!)
            
            callBack?((items: [previousSong!], section: .songList, typeOfChange: .modified, index: index))
        }
    }
    
    
    private func modifireSong(at list: inout [ViewModelTemplateSongProtocol], newItem: ViewModelTemplateSongProtocol) -> Int? {
        var itemIndex: Int? = nil
        
        list.enumerated().forEach { (index, item) in
            if item.getSongData() == newItem.getSongData() {
                list[index] = newItem
                itemIndex = index
            }
        }
        
        return itemIndex
    }
    
}
