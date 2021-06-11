//
//  PlayerManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 10.06.2021.
//

import Foundation
import AVFoundation
import MediaPlayer


class PlayerManager: NSObject, PlayerManagerProtocol {
    
    typealias SongData = (id: String, image: UIImage, song: Data, name: String, singer: String)
    
    static var shared: some PlayerManagerProtocol = PlayerManager()
    
    private(set) var currentSong: SongData?
    
    private var songsList: [SongData]?
    private let audioSession = AVAudioSession.sharedInstance()
    private var soundIndex: Int = 0
    private var player: AVAudioPlayer?
    
    
    private override init() {
        super.init()
        
        configureSession()
        songsList = [(id: "String", image: #imageLiteral(resourceName: "Group 257"), song: Data(), name: "Name", singer: "Singer")]
    }
    
    
    private func configureSession() {
        do {
            try audioSession.setCategory(.playback)
            try audioSession.setActive(true)
        }
        catch {
            fatalError("playback failed")
        }
    }
    
    
    func playSound(at index: Int) {
        
        guard currentSong?.id != songsList?[index].id else { player?.play(); return }
        guard let songData = songsList?[index] else { print("Song not found"); return }
        
        currentSong = songData
        
        do {
            player = try AVAudioPlayer(data: songData.song)
            player?.play()
            
            setupNowPlaying()
            setupRemoteCommandCenter()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    
    func configureSongList(with songs: [SongData], isNeedToClearCurrentPlayList: Bool = false) {
        if isNeedToClearCurrentPlayList {
            songsList = songs
        } else {
            songsList?.append(contentsOf: songs)
        }
    }
    
    
    func pauseSong() {
        player?.pause()
    }
    
    
    func stopSong() {
        player?.stop()
    }
    
    
    private func setupNowPlaying() {
        // Define Now Playing Info
        guard let songData = currentSong else { print("No songs to setup player"); return }
        
        let image = MPMediaItemArtwork(boundsSize: songData.image.size) {  (_) -> UIImage in
            return songData.image
        }
        
        var nowPlayingInfo = [String : Any]()
        
        nowPlayingInfo[MPMediaItemPropertyTitle]                    = songData.name
        nowPlayingInfo[MPMediaItemPropertyArtist]                   = songData.singer
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player?.currentTime
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration]         = player?.duration
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate]        = player?.rate
        nowPlayingInfo[MPMediaItemPropertyArtwork]                  = image
        
        // Set the metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
        MPNowPlayingInfoCenter.default().playbackState = .playing
    }
    
    
    
    private func setupRemoteCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget { [weak self] event in
            self?.player?.play()
            return .success
        }
        
        
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget { [weak self] event in
            self?.player?.pause()
            return .success
        }
        
        
        if songsList?[soundIndex + 1] != nil {
            commandCenter.nextTrackCommand.isEnabled = true
            commandCenter.nextTrackCommand.addTarget { [weak self] event -> MPRemoteCommandHandlerStatus in
                guard let self = self else { return .commandFailed }
                self.playSound(at: self.soundIndex + 1)
                
                return .success
            }
        }
        
        
        if songsList?[soundIndex - 1] != nil {
            commandCenter.previousTrackCommand.isEnabled = true
            commandCenter.previousTrackCommand.addTarget { [weak self] event -> MPRemoteCommandHandlerStatus in
                guard let self = self else { return .commandFailed }
                self.playSound(at: self.soundIndex - 1)
                
                return .success
            }
        }
        
        
        commandCenter.changePlaybackPositionCommand.isEnabled = true
        commandCenter.changePlaybackPositionCommand.addTarget { [weak self] event in
            
            self?.player?.currentTime = event.timestamp
            return .success
            
            //            if let event = event as? MPChangePlaybackPositionCommandEvent,
            //               let playerRate = self?.player?.rate {
            //                self?.player?
            //                self?.player?.seek(to: CMTime(seconds: event.positionTime, preferredTimescale: CMTimeScale(1000))) { [weak self] (success) in
            //
            //                    if success {
            //                        self?.player?.rate = playerRate
            //                    }
            //                }
            
        }
    }
    
    
    
}
