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
    
    var viewModel: MapCollectionViewCellModelViewProtocol = MapCollectionViewCellModelView()
    
    func updateContent<T> (with data: T) {
        guard let safeData = data as? MainScreenModelWrapper else { return }
        
        viewModel.callBack = { [weak self] model in
            
            self?.allUsers.text    = model.allUsers
            self?.onlineUsers.text = model.usersOnline
        }
        
        viewModel.handleData(with: safeData)
    }
}
