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

    
    func updateContent<T>(with viewModel: T) {
        guard let safeViewModel: MainScreenCollectionViewCellModelViewProtocol = viewModel as? MapCollectionViewCellModelView
        else { return }
    
        let data: (allUsers: String, usersOnline: String) = safeViewModel.getData()
        
        allUsers.text    = data.allUsers
        onlineUsers.text = data.usersOnline
    }
}
