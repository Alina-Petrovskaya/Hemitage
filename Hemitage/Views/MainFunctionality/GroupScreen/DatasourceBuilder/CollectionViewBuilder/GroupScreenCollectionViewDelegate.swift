//
//  GroupScreenCollectionViewDelegate.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 09.06.2021.
//

import UIKit

protocol GroupScreenCollectionDelegateProtocol {
    
    var collectionView: UICollectionView { get }
    var rowTapped: ((Int) -> ())? { get set }
    
}


class GroupScreenCollectionViewDelegate: NSObject, UICollectionViewDelegate, GroupScreenCollectionDelegateProtocol {
    
    var rowTapped: ((Int) -> ())?
    var requestForMoreItems: (() -> ())?
    var collectionView: UICollectionView
    
   
    init(with collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        
        collectionView.delegate = self
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        rowTapped?(indexPath.row)
    }
    
}
