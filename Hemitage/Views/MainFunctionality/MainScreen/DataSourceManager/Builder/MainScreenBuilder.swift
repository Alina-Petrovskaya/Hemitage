//
//  MainScreenBuilder.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 13.05.2021.
//

import UIKit

class MainScreenBuilder {
    
    let collectionViewDelegate = MainScreenCollectionViewDelegate()
  
    
    func build(with collectionView: UICollectionView, with viewModel: MainScreenViewModelProtocol) -> MainScreenDataSourceManagerProtocol {
        
        let layout               = MainScreenLayoutConstructor()
        let setupCollectionView  = MainScreenCollectionViewSetup(for: collectionView, with: collectionViewDelegate, with: layout)
        setupCollectionView.registerNibs()
        setupCollectionView.setLayout()
        
        let dataSourceManager = MainScreenDataSourceManager(for: collectionView, with: viewModel)
        dataSourceManager.reloadData()
        
        return dataSourceManager
    }
}
