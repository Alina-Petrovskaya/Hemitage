//
//  PlayerManagerProtocol.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 11.06.2021.
//

import Foundation

protocol PlayerManagerProtocol {
    
    var currentSong: ViewModelTemplateSong? { get }
    var songData: ((URL) -> ())? { get set }
    
    func playSong(at index: Int) -> ()
    func playSong(with data: Data)
    func configureSongList(with songs: [ViewModelTemplateSong]) -> ()
    func stopSong()
}
