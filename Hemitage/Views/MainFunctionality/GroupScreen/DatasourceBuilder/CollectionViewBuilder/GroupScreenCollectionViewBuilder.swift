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
        guard let collectionView = object as? UICollectionView else { return }
        
        let cellId = String(describing: GroupScreenSubgroupCell.self)
        collectionView.register(UINib(nibName: cellId, bundle: .main), forCellWithReuseIdentifier: cellId)
    }
    
    
    func setupDataSource<T: GroupScreenViewModelProtocol>(for object: UIScrollView, with viewModel: T) -> GroupScreenDataSourceProtocol? {
        guard let collectionView = object as? UICollectionView else { return nil }
        
        let dataSource: GroupScreenDataSourceProtocol = GroupScreenCollectionViewDatasource(with: collectionView)
        dataSource.reloadData(with: viewModel)
        
        return dataSource
    }
    
}
