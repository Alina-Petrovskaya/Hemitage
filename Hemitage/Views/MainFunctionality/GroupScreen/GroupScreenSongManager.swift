//
//  GroupScreenSongManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 11.06.2021.
//

import Foundation
import Network

class GroupScreenSongManager {
    
    var getDataFromFB: ((SubscriptionAndNetworkStatus) -> ())?
    var songList: [ViewModelTemplateSong] = []
    
    private let monitor = NWPathMonitor()
    private var status: SubscriptionAndNetworkStatus = .unowned
    
    private var premiumMusic: [ViewModelTemplateSong] = []
    private var canPlaySong: Bool = true
    private let cacheManager = CacheManager()
    
    
    init() {
        monitorNetwork()
        canPlaySong = status.isCanPlayMusic()
    }
    
    
    private func monitorNetwork() {
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                self?.status = .standart
                self?.monitor.cancel()
                
                self?.songList.removeAll()
                self?.getDataFromFB?(.standart)
                
            } else {
                self?.status = .noNetworkSubscription
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
                                         isHideCloseButton: true)
        }
        
        if songList.count == 0 {
            songList.append(contentsOf: items)
            return (songs: items, isNeedReload: true)
            
        } else {
            songList.append(contentsOf: items)
            return (songs: items, isNeedReload: false)
        }
    }
    
    
    private func manageMusic(with: [ViewModelTemplateSong], index: Int?) {
        PlayerManager.shared.songData = { [weak self] url in
            
            self?.cacheManager.cacheSongObject(songURL: url, requestType: .get) { data in
                PlayerManager.shared.playSong(with: data)
            }
        }
    }
    
    
}
