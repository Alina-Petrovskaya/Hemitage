//
//  PlayerObserver.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 15.06.2021.
//

import Foundation
import MediaPlayer

protocol PlayerObserver: AnyObject {
    func playerStateChanged(isPlaying: Bool, currentSong: ViewModelTemplateSongProtocol?, previousSong: ViewModelTemplateSongProtocol?)
}

