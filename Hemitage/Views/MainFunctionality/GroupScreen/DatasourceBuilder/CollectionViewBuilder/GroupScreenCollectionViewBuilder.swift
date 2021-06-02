//
//  GroupScreenCollectionViewBuilder.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 02.06.2021.
//

import UIKit

class GroupScreenCollectionViewBuilder: GroupScreenBuilder {
    
    func setLayout(for object: UIScrollView) {
        guard let collectionView = object as? UICollectionView else { return }
        
        collectionView.collectionViewLayout = GroupScreenCollectionViewLayoutConstructor().createLayout()
        
    }
    
    func registerNibs(for object: UIScrollView) {
        //        guard let collectionView = object as? UICollectionView else { return }
        
    }
    
    func setupDataSource<T: GroupScreenViewModelProtocol>(for object: UIScrollView, with viewModel: T) {
        //        guard let collectionView = object as? UICollectionView else { return }
        
    }
    
}
