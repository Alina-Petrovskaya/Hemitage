//
//  MapCollectionViewCell.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 06.05.2021.
//

import UIKit

class MapCollectionViewCell: UICollectionViewCell, ConfiguringCell {

    @IBOutlet weak var allUsers: UILabel!
    @IBOutlet weak var onlineUsers: UILabel!
    
    func updateContent<T> (with data: T) {
        guard let safeData = data as? MainScreenModelWrapper else { return }
        
        switch safeData {
        case .map(let data):
            allUsers.text    = "\(data.allUsers)"
            onlineUsers.text = "\(data.usersOnline)"
            
        case .category(_):
            break
            
        case .blog(_):
            break
        }
    }
}
