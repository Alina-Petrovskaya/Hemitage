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
    let imageName: String
}
