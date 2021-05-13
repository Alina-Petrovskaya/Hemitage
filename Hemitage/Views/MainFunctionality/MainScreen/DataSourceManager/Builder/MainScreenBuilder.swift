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
        
        let layout                     = MainScreenLayoutConstructor()
        let configuratedCollectionView = MainScreenCollectionViewSetup(for: collectionView,
                                                                       with: collectionViewDelegate,
                                                                       with: layout)
        
        let dataSourceManager = MainScreenDataSourceManager(with: collectionView, with: viewModel)
        
        return dataSourceManager
    }
}
