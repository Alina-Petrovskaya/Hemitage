//
//  PlayerManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 10.06.2021.
//

import Foundation
import AVFoundation
import MediaPlayer
import SDWebImage


class PlayerManager: NSObject, PlayerManagerProtocol, AVAudioPlayerDelegate {
    
    static var shared: some PlayerManagerProtocol = PlayerManager()
    
    var songData: ((URL) -> ())?
    
    private(set) var currentSong:  ViewModelTemplateSong?
    private var songsList: [ViewModelTemplateSong]?
    private let audioSession = AVAudioSession.sharedInstance()
    private var soundIndex: Int = 0
    private var player: AVAudioPlayer!
    
    
    private override init() {
        super.init()
        player?.delegate = self
        configureSession()
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
    
    
    func playSong(at index: Int) {
        if currentSong?.getID() == songsList?[index].getID() {
            if player.isPlaying {
                player?.pause()
                
            } else {
                player?.play()
            }
            
        } else {
            guard let song      = songsList?[index],
                  let songURL   = song.getData().imageURL
            else {
                print("Song not found")
                return
            }
            
            soundIndex  = index
            currentSong = song
            songData?(songURL)
        }
    }
    
    
    func playSong(with data: Data) {
        do {
            player = try AVAudioPlayer(data: data)
            player?.play()
            
            setupNowPlaying()
            setupRemoteCommandCenter()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    
    func configureSongList(with songs: [ViewModelTemplateSong]) {
        songsList = songs
    }
    
    
    func stopSong() {
        player?.stop()
    }
    
    
    private func setupNowPlaying() {
        // Define Now Playing Info
        guard let songData = currentSong?.getData() else { print("No songs to setup player"); return }
        
        let image: UIImage = {
            let view = UIImageView()
            view.sd_setImage(with: songData.imageURL)
            return view.image ?? #imageLiteral(resourceName: "Picture Placeholder")
        }()
        
        let playerImage = MPMediaItemArtwork(boundsSize: image.size) {  (_) -> UIImage in
            return image
        }
        
        var nowPlayingInfo = [String : Any]()
        
        nowPlayingInfo[MPMediaItemPropertyTitle]                    = songData.title
        nowPlayingInfo[MPMediaItemPropertyArtist]                   = songData.subtitle
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player?.currentTime
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration]         = player?.duration
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate]        = player?.rate
        nowPlayingInfo[MPMediaItemPropertyArtwork]                  = playerImage
        
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
                self.soundIndex += 1
                self.playSong(at: self.soundIndex + 1)
                
                return .success
            }
        }
        
        
        if songsList?[soundIndex - 1] != nil {
            commandCenter.previousTrackCommand.isEnabled = true
            commandCenter.previousTrackCommand.addTarget { [weak self] event -> MPRemoteCommandHandlerStatus in
                guard let self = self else { return .commandFailed }
                self.playSong(at: self.soundIndex - 1)
                self.soundIndex -= 1
                
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
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if songsList?[soundIndex + 1] != nil {
            self.playSong(at: self.soundIndex + 1)
            self.soundIndex += 1
        }
    }
    
}
