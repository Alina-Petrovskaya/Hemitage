//
//  PlayerManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 10.06.2021.
//

import Foundation
import AVFoundation
import MediaPlayer


class PlayerManager: NSObject, PlayerManagerProtocol, AVAudioPlayerDelegate {

    static var shared: some PlayerManagerProtocol = PlayerManager()
    
    var callForSongData: (((index: Int, url: URL)) -> ())?
    
    private var observers: [PlayerObserver] = []
    private var songsList: [ViewModelTemplateSongProtocol] = []
    private var soundIndex   = 0
    private let mediaPlayer  = MediaPlayerManager()
    
    private var playerState: MPNowPlayingPlaybackState = .unknown {
        didSet { notify(playerState: playerState, currentsong: currentSong, previousSong: nil) }
    }
    
    private var currentSong: ViewModelTemplateSongProtocol? {
        didSet {
            notify(playerState: playerState, currentsong: currentSong, previousSong: oldValue)
            mediaPlayer.songData = currentSong
        }
    }
    
    
    private override init() {
        super.init()
        setupPlayer()
    }
    

    func playSong(at index: Int) {
        guard index <= songsList.count - 1, index >= 0 else {
            mediaPlayer.player?.stop()
            mediaPlayer.setupNowPlaying(.stopped)
            return
        }
        
        guard currentSong?.getSongData().id != songsList[index].getSongData().id else {
            if mediaPlayer.player?.isPlaying == true {
                mediaPlayer.setupNowPlaying(.paused)
                mediaPlayer.player?.pause()
                
            } else {
                mediaPlayer.setupNowPlaying(.playing)
                mediaPlayer.player?.play()
            }
            return
        }
        
        guard let songURL = songsList[index].getSongData().songURL else {
            print("Song not found")
            return
        }
        
        soundIndex = index
        currentSong = songsList[soundIndex]
        callForSongData?((index: index, url: songURL))
        mediaPlayer.setupRemoteCommandCenter(numberOfSongs: songsList.count, soundIndex: soundIndex)
    }
    
    
    func playSong(with data: Data) {
        do {
            self.mediaPlayer.player = try AVAudioPlayer(data: data)
            self.mediaPlayer.player?.delegate = self
            
            self.mediaPlayer.player?.prepareToPlay()
            self.mediaPlayer.player?.play()
            self.mediaPlayer.setupNowPlaying(.playing)
            
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    func configureSongList(with songs: [ViewModelTemplateSongProtocol]) {
        songsList = songs
    }
    
    
    func getIdOfPlayingSong() -> String? {
        if playerState == .playing {
            return currentSong?.getSongData().id
        }
        return nil
    }
    
    
    func stopSong() {
        mediaPlayer.player?.stop()
        mediaPlayer.setupNowPlaying(.stopped)
    }
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.playSong(at: self.soundIndex + 1)
    }
    
    // MARK: - Observe State
    func subscribe(_ observer: PlayerObserver) {
        observers.append(observer)
    }
    
    
    func unSubscribe(_ observer: PlayerObserver) {
        if let index = observers.firstIndex(where: { $0 === observer }) {
            observers.remove(at: index)
        }
    }
    
    
    private func notify(playerState: MPNowPlayingPlaybackState, currentsong: ViewModelTemplateSongProtocol?, previousSong: ViewModelTemplateSongProtocol?) {
        observers.forEach { $0.playerStateChanged(isPlaying: playerState == .playing, currentSong: currentsong, previousSong: previousSong) }
    }
    
   // MARK: - Player Setup
    private func setupPlayer() {
        mediaPlayer.setupControls { [weak self] tappedNexSong in
            guard let safeIndex = self?.soundIndex else { return }
            if tappedNexSong {
                self?.playSong(at: safeIndex + 1)
            } else {
                self?.playSong(at: safeIndex - 1)
            }
        }
        
        mediaPlayer.setupTargets { [weak self] state in
            self?.playerState = state
        }
        
    }

}
