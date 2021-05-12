//
//  MainScreenCollectionViewDelegate.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 12.05.2021.
//

import UIKit

class MainScreenCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    var callBack: ((MainScreenModelWrapper) -> ())?
    
    private let dataManager = MainScreenDataManager()
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cellType = MainScreenTypeOfSection(rawValue: indexPath.section) else { return }
        
        switch cellType {
        
        case .map:
            break
            
        case .categories:
            callBack?(dataManager.categoriesdata[indexPath.row])
            
        case .blog:
            callBack?(dataManager.blogData[indexPath.row])
        }
    }
}
