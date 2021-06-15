//
//  PlayerObserver.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 15.06.2021.
//

import Foundation
import MediaPlayer

protocol PlayerObserver: class {
    func playerStateChanged(state: MPNowPlayingPlaybackState, currentSong: ViewModelTemplateSong?, previousSong: ViewModelTemplateSong?)
}

