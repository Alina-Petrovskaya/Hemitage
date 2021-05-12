//
//  ViewModelTemplateSong.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 12.05.2021.
//

import Foundation

class ViewModelTemplateSong: TemplatesViewModelProtocol {
    var dataModel: ((SongModel) -> ())?
    
    func getDataForContent() {
        //Get data from resource
        
        let model = SongModel(songName: "Delta waves & oceanic song", singer: "Artist name", imageName: "Meditation")
            dataModel?(model)
    }
}
