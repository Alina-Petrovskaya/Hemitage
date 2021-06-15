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
    private var songsList: [ViewModelTemplateSong] = []
    private let audioSession = AVAudioSession.sharedInstance()
    private var soundIndex   = 0
    private let mediaPlayer  = MediaPlayerManager()
    
    var playerState: MPNowPlayingPlaybackState = .unknown {
        didSet { notify(playerState: playerState, currentsong: currentSong, previousSong: nil) }
    }
    
    var currentSong: ViewModelTemplateSong? {
        didSet {
            notify(playerState: playerState, currentsong: currentSong, previousSong: oldValue)
            mediaPlayer.songData = currentSong?.getData()
        }
    }
    
    
    private override init() {
        super.init()
        configureSession()
        setupPlayer()
    }
    

    func playSong(at index: Int) {
        guard index <= songsList.count - 1, index >= 0 else {
            mediaPlayer.player?.stop()
            mediaPlayer.setupNowPlaying(.stopped)
            return
        }
        
        guard currentSong?.getID() != songsList[index].getID() else {
            if mediaPlayer.player?.isPlaying == true {
                mediaPlayer.setupNowPlaying(.interrupted)
                mediaPlayer.player?.pause()
                
            } else {
                mediaPlayer.setupNowPlaying(.playing)
                mediaPlayer.player?.play()
            }
            return
        }
        
        guard let songURL = songsList[index].getSongURL() else {
            print("Song not found")
            return
        }
        
        soundIndex = index
        currentSong = songsList[soundIndex]
        callForSongData?((index: index, url: songURL))
        mediaPlayer.setupRemoteCommandCenter(numberOfSongs: songsList.count, soundIndex: soundIndex)
    }
    
    
    func playSong(with data: Data) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
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
    }
    
    
    func configureSongList(with songs: [ViewModelTemplateSong]) {
        songsList = songs
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
    
    private func notify(playerState: MPNowPlayingPlaybackState, currentsong: ViewModelTemplateSong?, previousSong: ViewModelTemplateSong?) {
        observers.forEach { $0.playerStateChanged(state: playerState, currentSong: currentsong, previousSong: previousSong) }
    }
    
   // MARK: - Player Setup
    private func configureSession() {
        do {
            try audioSession.setCategory(.playback)
            try audioSession.setActive(true)
        }
        catch {
            fatalError("playback failed")
        }
    
    }
    
    
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
