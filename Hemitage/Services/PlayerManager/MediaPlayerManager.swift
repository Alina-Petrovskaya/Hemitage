//
//  MediaPlayerManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 15.06.2021.
//

import Foundation
import MediaPlayer
import SDWebImage

class MediaPlayerManager {
    
    var songData: ViewModelTemplateSongProtocol?
    var player: AVAudioPlayer!
    private let audioSession = AVAudioSession.sharedInstance()
    
    
    init() {
        
        do {
            try audioSession.setCategory(.playback)
            try audioSession.setActive(true)
        }
        catch {
            fatalError("playback failed")
        }
    }
    
    func setupNowPlaying(_ state: MPNowPlayingPlaybackState?) {
        // Define Now Playing Info
        var nowPlayingInfo = [String : Any]()
        let song = songData?.getSongData()
        
        let image: UIImage = {
            let view = UIImageView()
            view.sd_setImage(with: song?.imageURL)
            return view.image ?? #imageLiteral(resourceName: "Picture Placeholder")
        }()
        
        let playerImage = MPMediaItemArtwork(boundsSize: image.size) {  (_) -> UIImage in
            return image
        }
        
        
        if state == .stopped {
            MPNowPlayingInfoCenter.default().nowPlayingInfo = [:]
            
        } else {
            nowPlayingInfo[MPMediaItemPropertyTitle]                    = song?.title
            nowPlayingInfo[MPMediaItemPropertyArtist]                   = song?.subtitle
            nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player?.currentTime
            nowPlayingInfo[MPMediaItemPropertyPlaybackDuration]         = player?.duration
            nowPlayingInfo[MPMediaItemPropertyArtwork]                  = playerImage
            
            // Set the metadata
            MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
        }
        
        if state != .playing {
            nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 0.0
        }
        
        if let safeState = state {
            MPNowPlayingInfoCenter.default().playbackState = safeState
        }
    }
    
    
    func setupRemoteCommandCenter(numberOfSongs: Int, soundIndex: Int) {
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.togglePlayPauseCommand.isEnabled = true
        commandCenter.nextTrackCommand.isEnabled = numberOfSongs - 1 > soundIndex ? true : false
        commandCenter.previousTrackCommand.isEnabled = soundIndex > 0 ? true : false
        commandCenter.changePlaybackPositionCommand.isEnabled = true
    }
    
    
    func setupTargets(completion: @escaping (MPNowPlayingPlaybackState) -> ()) {
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.togglePlayPauseCommand.addTarget { [weak self] event in
            if self?.player?.isPlaying == true {
                self?.setupNowPlaying(.paused)
                
                self?.player?.pause()
                completion(.paused)
                
            } else {
                completion(.playing)
                self?.setupNowPlaying(.playing)
                self?.player?.play()
            }
            
            return .success
        }
        

        commandCenter.changePlaybackPositionCommand.addTarget { [weak self] event in
            guard let self = self else { return .commandFailed }

            if let changePlaybackPositionCommandEvent = event as? MPChangePlaybackPositionCommandEvent {

                let positionTime = changePlaybackPositionCommandEvent.positionTime
                self.player?.currentTime = positionTime
                let playerState: MPNowPlayingPlaybackState = self.player.isPlaying == true ? .playing : .paused
                self.setupNowPlaying(playerState)

                return .success
            }
            return .commandFailed
        }
    }
    
    
    func setupControls(completion: @escaping (Bool) -> ()) {
        let commandCenter = MPRemoteCommandCenter.shared()

        commandCenter.nextTrackCommand.addTarget { event -> MPRemoteCommandHandlerStatus in
            completion(true)
            return .success
        }

        commandCenter.previousTrackCommand.addTarget { event -> MPRemoteCommandHandlerStatus in
            completion(false)
            return .success
        }
    }
}
