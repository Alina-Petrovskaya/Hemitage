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
    
    var songData: (((index: Int, url: URL)) -> ())?
    
    private(set) var currentSong:  ViewModelTemplateSong?
    private var songsList: [ViewModelTemplateSong]?
    private let audioSession = AVAudioSession.sharedInstance()
    private var soundIndex: Int = 0
    private var player: AVAudioPlayer?
    
    
    private override init() {
        super.init()
        
        setupTargets()
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
        guard songsList != nil,
              index <= songsList!.count - 1,
              index >= 0 else {
            player?.stop()
            setupNowPlaying(.stopped)
            return
        }
        
        if currentSong?.getID() == songsList?[index].getID() {
            if player?.isPlaying == true {
                player?.pause()
                setupNowPlaying(.paused)
            } else {
                setupNowPlaying(.playing)
                player?.play()
                
            }
            
        } else {
            guard let song = songsList?[index], let songURL = song.getSongURL()
            else {
                print("Song not found")
                return
            }
            
            soundIndex = index
            songData?((index: index, url: songURL))
            setupRemoteCommandCenter()
        }
    }
    
    
    func playSong(with data: Data) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            do {
                self.player = try AVAudioPlayer(data: data)
                self.player?.delegate = self
                
                self.player?.prepareToPlay()
                self.player?.play()
                
                self.currentSong = self.songsList?[self.soundIndex]
                self.setupNowPlaying(.playing)
                
                
            } catch let error {
                print(error.localizedDescription)
            }
            
        }
    }
    
    
    func configureSongList(with songs: [ViewModelTemplateSong]) {
        songsList = songs
    }
    
    
    func stopSong() {
        player?.stop()
        setupNowPlaying(.stopped)
        
    }
    
    
    private func setupNowPlaying(_ state: MPNowPlayingPlaybackState) {
        // Define Now Playing Info
        guard let songData = currentSong?.getData() else { print("No songs to setup player"); return }
        
        let image: UIImage = {
            let view = UIImageView()
            view.sd_setImage(with: songData.imageURL)
            return view.image ?? #imageLiteral(resourceName: "Picture Placeholder")
        }()
        
        let playerImage = MPMediaItemArtwork(boundsSize: CGSize(width: 200, height: 200)) {  (_) -> UIImage in
            return image
        }
        
        var nowPlayingInfo = [String : Any]()
        
        nowPlayingInfo[MPMediaItemPropertyTitle]                    = songData.title
        nowPlayingInfo[MPMediaItemPropertyArtist]                   = songData.subtitle
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player?.currentTime
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration]         = player?.duration
        nowPlayingInfo[MPMediaItemPropertyArtwork]                  = playerImage
        
        
        // Set the metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
        MPNowPlayingInfoCenter.default().playbackState = state
    }
    
    
    
    private func setupRemoteCommandCenter() {
        guard songsList != nil else { return }
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.playCommand.isEnabled = true
        commandCenter.pauseCommand.isEnabled = true
        
        commandCenter.nextTrackCommand.isEnabled = songsList!.count - 1 > soundIndex ? true : false
        commandCenter.previousTrackCommand.isEnabled = soundIndex > 0 ? true : false
        commandCenter.changePlaybackPositionCommand.isEnabled = true
    }
    
    
    private func setupTargets() {
        let commandCenter = MPRemoteCommandCenter.shared()
    
        commandCenter.pauseCommand.addTarget { [weak self] event in
            self?.setupNowPlaying(.paused)
            self?.player?.pause()
            return .success
        }
        
        
        commandCenter.playCommand.addTarget { [weak self] event in
            self?.setupNowPlaying(.playing)
            self?.player?.play()
            return .success
        }
        
        
        commandCenter.nextTrackCommand.addTarget { [weak self] event -> MPRemoteCommandHandlerStatus in
            guard let self = self else { return .commandFailed }
            self.soundIndex += 1
            self.playSong(at: self.soundIndex)
            
            return .success
        }
        
        
        
        commandCenter.previousTrackCommand.addTarget { [weak self] event -> MPRemoteCommandHandlerStatus in
            guard let self = self else { return .commandFailed }
            
            self.soundIndex -= 1
            self.playSong(at: self.soundIndex)
            
            return .success
        }
        
        
        commandCenter.changePlaybackPositionCommand.addTarget { [weak self] event in
            if let changePlaybackPositionCommandEvent = event as? MPChangePlaybackPositionCommandEvent {

                let positionTime = changePlaybackPositionCommandEvent.positionTime
                
                self?.player?.currentTime = positionTime
                self?.setupNowPlaying(.interrupted)
                
                return .success
            }
            return .commandFailed
        }
    }
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.playSong(at: self.soundIndex + 1)
        self.soundIndex += 1
    }
    
}
