//
//  PlayerManagerProtocol.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 11.06.2021.
//

import Foundation

protocol PlayerManagerProtocol {
    associatedtype SongData
    
    var  currentSong: SongData? { get }
    
    func playSound(at index: Int) -> ()
    func configureSongList(with songs: [SongData], isNeedToClearCurrentPlayList: Bool) -> ()
    func pauseSong()
    func stopSong()
}
