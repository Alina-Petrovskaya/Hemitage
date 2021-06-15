//
//  GroupScreenSongManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 11.06.2021.
//

import Foundation
import Network



class GroupScreenSongManager {
    
    var getData: (() -> ())?
    var songList: [ViewModelTemplateSong] = []
    var callBack: ( ((items: [ViewModelTemplateSong], section: GroupScreenTypeOfContent, typeOfChange: TypeOfChangeDocument, index: Int?)) -> () )?
    
    private let monitor = NWPathMonitor()
    private var status: SubscriptionAndNetworkStatus = .unowned
    private var premiumMusic: [ViewModelTemplateSong] = []
    private var canPlaySong: Bool = true
    private let cacheManager = CacheManager()
    
    
    init() {
        monitorNetwork()
        canPlaySong = status.isCanPlayMusic()
        manageDataMusic()
    }
    
    
    private func monitorNetwork() {
        monitor.pathUpdateHandler = { [weak self] path in
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
    
    
    func playSong(at index: Int) {
        PlayerManager.shared.configureSongList(with: songList)
        PlayerManager.shared.playSong(at: index)
    }
    
    
    func addSongs(songs: [SongModel]) -> (songs: [ViewModelTemplateSong], isNeedReload: Bool) {
        let currentSongID = PlayerManager.shared.currentSong?.getID()
        let items = songs.compactMap { model -> ViewModelTemplateSong in
            
            return ViewModelTemplateSong(songModel: model,
                                         isPlaying: currentSongID == model.id,
                                         isHideCloseButton: true,
                                         isCanPlay: status.isCanPlayMusic(),
                                         isSaved: cacheManager.isSongSaved(songURL: model.songURL))
        }
        
        if songList.count == 0 {
            songList.append(contentsOf: items)
            return (songs: items, isNeedReload: true)
            
        } else {
            songList.append(contentsOf: items)
            return (songs: items, isNeedReload: false)
        }
    }
    
    
    
    
    
    private func manageDataMusic() {
        PlayerManager.shared.songData = { [weak self] dataFromPlayer in
            self?.cacheManager.cacheSongObject(songURL: dataFromPlayer.url, requestType: .get) { result in
                //
                switch result {
                
                case .success(let data):
                    PlayerManager.shared.playSong(with: data)
                    
                case .failure(_):
                    PlayerManager.shared.playSong(at: dataFromPlayer.index + 1)
                }
            }
        }
    }
    
    
}
