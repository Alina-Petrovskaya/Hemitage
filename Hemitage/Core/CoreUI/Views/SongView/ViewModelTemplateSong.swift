//
//  ViewModelTemplateSong.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 12.05.2021.
//

import Foundation

protocol ViewModelTemplateSongProtocol {
    
    func getSongData() -> (id: String, title: String, subtitle: String, songURL: URL?, imageURL: URL?)
    func updatePlayingState(isPlay: Bool)
    func updateSavingState(isSaved: Bool)
    
}

class ViewModelTemplateSong: ViewModelConfigurator, ViewModelTemplateSongProtocol, Hashable {

    typealias DataType = (title: String, subtitle: String?, isPlaying: Bool, isHideCloseButton: Bool, imageURL: URL?, isCanPlay: Bool, isSaved: Bool)
    
    private let id: String
    private var title: String
    private var subtitle: String?
    private var isPlaying: Bool = false
    private let isHideCloseButton: Bool
    private var imageURL: URL?
    private var songURL: URL?
    private var isCanPlay: Bool
    private var isSaved: Bool
    
    
    init(songModel: SongModel, isPlaying: Bool = false, isHideCloseButton: Bool = false, isCanPlay: Bool = false, isSaved: Bool = false) {
        id                     = songModel.id ?? "nil"
        title                  = songModel.songName
        subtitle               = songModel.singer
        songURL                = songModel.songURL
        imageURL               = songModel.imageURL
        self.isSaved           = isSaved
        self.isCanPlay         = isCanPlay
        self.isPlaying         = isPlaying
        self.isHideCloseButton = isHideCloseButton
    }
    
    
    func getData() -> DataType {
        return (title, subtitle, isPlaying, isHideCloseButton, imageURL, isCanPlay, isSaved)
    }
    
    
    func setData(with data: DataType) {
        title     = data.title
        subtitle  = data.subtitle
        imageURL  = data.imageURL
        isPlaying = data.isPlaying
        isCanPlay = data.isCanPlay
        isSaved   = data.isSaved
    }
    
    
    func getSongData() -> (id: String, title: String, subtitle: String, songURL: URL?, imageURL: URL?) {
        return (id, title, subtitle ?? "", songURL, imageURL)
    }
    
    
    func getID() -> String {
        return id
    }
    
    func updatePlayingState(isPlay: Bool) {
        isPlaying = isPlay
    }
    
    func updateSavingState(isSaved: Bool) {
        self.isSaved = isSaved
    }
    
    static func == (lhs: ViewModelTemplateSong, rhs: ViewModelTemplateSong) -> Bool {
        return lhs.id                == rhs.id
            && lhs.title             == rhs.title
            && lhs.subtitle          == rhs.subtitle
            && lhs.isPlaying         == rhs.isPlaying
            && lhs.isHideCloseButton == rhs.isHideCloseButton
            && lhs.imageURL          == rhs.imageURL
            && lhs.isCanPlay         == rhs.isCanPlay
            && lhs.isSaved           == rhs.isSaved
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
