//
//  SongModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 11.05.2021.
//

import Foundation
import FirebaseFirestoreSwift

struct SongModel: Hashable, Codable, Identifiable {
    @DocumentID var id: String? 
    let songName: String
    let singer: String
    let imageURL: URL?
    let songURL: URL?
    let raiting: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
