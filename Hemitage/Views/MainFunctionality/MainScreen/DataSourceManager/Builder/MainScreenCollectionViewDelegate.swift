//
//  MainScreenCollectionViewDelegate.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 12.05.2021.
//

import UIKit


class MainScreenCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    var callBack: ((IndexPath) -> ())?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        callBack?(indexPath)
    }
    
}
