//
//  MainScreenBuilder.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 13.05.2021.
//

import UIKit

class MainScreenBuilder {
    
    func build(with collectionView: UICollectionView, with viewModel: MainScreenViewModelProtocol) -> MainScreenDataSourceManagerProtocol {
        
        let layout               = MainScreenLayoutConstructor()
        let setupCollectionView  = MainScreenCollectionViewSetup(for: collectionView, with: layout)
        setupCollectionView.registerNibs()
        setupCollectionView.setLayout()
        
        let dataSourceManager = MainScreenDataSourceManager(for: collectionView)
        dataSourceManager.reloadData(with: viewModel)
        
        return dataSourceManager
    }
}
