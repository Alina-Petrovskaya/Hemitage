//
//  PlayerManagerProtocol.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 11.06.2021.
//

import Foundation

protocol PlayerManagerProtocol {
    
    var callForSongData: ( ((index: Int, url: URL, id: String)) -> () )? { get set }

    func playSong(at index: Int) -> ()
    func playSong(with data: Data)
    func configureSongList(with songs: [ViewModelTemplateSongProtocol]) -> ()
    func stopSong()
    func getIdOfPlayingSong() -> String?
    func subscribe(_ observer: PlayerObserver)
    func unSubscribe(_ observer: PlayerObserver)
    
    
}
