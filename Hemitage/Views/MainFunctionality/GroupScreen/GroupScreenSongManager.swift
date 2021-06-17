//
//  GroupScreenSongManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 11.06.2021.
//

import Foundation
import Network

class GroupScreenSongManager: PlayerObserver {
    
    var getData: (() -> ())?
    var songList: [ViewModelTemplateSongProtocol] = []
    var premiumMusic: [ViewModelTemplateSongProtocol] = []
    var callBack: ( ((items: [ViewModelTemplateSongProtocol], section: GroupScreenTypeOfContent, typeOfChange: TypeOfChangeDocument, index: Int?)) -> () )?
    var currentSongSection: GroupScreenTypeOfContent = .songList
    
    private let monitor = NWPathMonitor()
    private let cacheManager = CacheManager()
    private var status: SubscriptionAndNetworkStatus = .unowned
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
                self?.status = .standart
                self?.songList.removeAll()
                self?.getData?()
                
            } else {
                self?.status = .noNetworkNoSubscription
            }
        }
        
        let queue = DispatchQueue.global()
        monitor.start(queue: queue)
    }
    
    // MARK: - Configure Playlist
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
        
        if songList.count == 0 {
            songList.append(contentsOf: items)
            return (songs: items, isNeedReload: true)
            
        } else {
            songList.append(contentsOf: items)
            return (songs: items, isNeedReload: false)
        }
    }
    
    
    func manageSongSaving(index: Int, section: GroupScreenTypeOfContent) {
        let songModel = (section == .songList)
            ? songList[index]
            : premiumMusic[index]
        
        guard let songURL = songModel.getSongData().songURL else { return }
        let id = songModel.getSongData().id
        if cacheManager.isSongSaved(docimentID: id) {
            cacheManager.cacheSongObject(songURL: songURL, documentID: id, requestType: .delete, completion: nil)
            songModel.updateSavingState(isSaved: false)
            
        } else {
            cacheManager.cacheSongObject(songURL: songURL, documentID: id, requestType: .save, completion: nil)
            songModel.updateSavingState(isSaved: true)
        }

        callBack?((items: [songModel], section: .songList, typeOfChange: .modified, index: nil))
    }
    
    
    // MARK: - Music control
    func playSong(at index: Int, _ section: GroupScreenTypeOfContent) {
        PlayerManager.shared.configureSongList(with: section == .songList ? songList : premiumMusic)
        PlayerManager.shared.playSong(at: index)
    }
    
    
    private func manageDataMusic() {
        PlayerManager.shared.callForSongData = { [weak self] dataFromPlayer in
            self?.cacheManager.cacheSongObject(songURL: dataFromPlayer.url, documentID: dataFromPlayer.id, requestType: .get) { result in
                
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
            if currentSongSection == .songList {
                let index = modifireSong(at: &songList, newItem: currentSong!)
                callBack?((items: [currentSong!], section: .songList, typeOfChange: .modified, index: index))
                
            } else {
                let index = modifireSong(at: &premiumMusic, newItem: currentSong!)
                callBack?((items: [currentSong!], section: .songList, typeOfChange: .modified, index: index))
            }
           
            
        }
        if previousSong != nil {
            previousSong?.updatePlayingState(isPlay: false)
            callBack?((items: [previousSong!], section: .songList, typeOfChange: .modified, index: nil))
        }
    }
    
    
    private func modifireSong(at list: inout [ViewModelTemplateSongProtocol], newItem: ViewModelTemplateSongProtocol) -> Int? {
        let index = list.firstIndex(where: { item in
            item.getSongData() == newItem.getSongData()
        })
        
        if index != nil {
            list[index!] = newItem
            
            return index
        }
        
        return nil
    }
    
}
