//
//  MainScreenCollectionViewDelegate.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 12.05.2021.
//

import UIKit

class MainScreenCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    var callBack: ((MainScreenModelWrapper) -> ())?
    
    private let dataManager: MainScreenDataManagerProtocol = MainScreenDataManager()
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = dataManager.getItem(for: indexPath) {
            callBack?(item)
        }
    }
}
