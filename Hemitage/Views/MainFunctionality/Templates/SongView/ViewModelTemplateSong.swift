//
//  ViewModelTemplateSong.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 12.05.2021.
//

import Foundation

class ViewModelTemplateSong: ViewModelConfigurator, Hashable {

    typealias DataType = (title: String, subtitle: String?, isPlaying: Bool, isHideCloseButton: Bool, imageURL: URL?)
    
    private let id: String
    private var title: String
    private var subtitle: String?
    private var isPlaying: Bool = false
    private let isHideCloseButton: Bool
    private var imageURL: URL?
    private var songURL: URL?
    
    
    init(songModel: SongModel, isPlaying: Bool = false, isHideCloseButton: Bool = false ) {
        id                     = songModel.id ?? "nil"
        title                  = songModel.songName
        subtitle               = songModel.singer
        songURL                = songModel.songURL
        imageURL               = songModel.imageURL
        self.isPlaying         = isPlaying
        self.isHideCloseButton = isHideCloseButton
    }
    
    
    func getData() -> DataType {
        return (title, subtitle, isPlaying, isHideCloseButton, imageURL)
    }
    
    
    func setData(with data: DataType) {
        title                  = data.title
        subtitle               = data.subtitle
        imageURL               = data.imageURL
        isPlaying              = data.isPlaying
    }
    
    
    func getSongURL() -> URL? {
        return songURL
    }
    
    func getID() -> String {
        return id
    }
    
    static func == (lhs: ViewModelTemplateSong, rhs: ViewModelTemplateSong) -> Bool {
        return lhs.id                == rhs.id
            && lhs.title             == rhs.title
            && lhs.subtitle          == rhs.subtitle
            && lhs.isPlaying         == rhs.isPlaying
            && lhs.isHideCloseButton == rhs.isHideCloseButton
            && lhs.imageURL          == rhs.imageURL
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
