//
//  MainScreenCollectionViewSetup.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 13.05.2021.
//

import UIKit

class MainScreenCollectionViewSetup {
    
    private let collectionView: UICollectionView
    private let layout: MainScreenLayoutConstructorProtocol
    
    init(for collectionView: UICollectionView, with delegate: MainScreenCollectionViewDelegate, with customLayout: MainScreenLayoutConstructorProtocol) {
        
        self.collectionView = collectionView
        self.layout = customLayout
        
        collectionView.delegate = delegate
    }
    
    func registerNibs() {
        collectionView.register(UINib(nibName: String(describing: MapCollectionViewCell.self), bundle: .main),
                                forCellWithReuseIdentifier: String(describing: MapCollectionViewCell.self))
        
        collectionView.register(UINib(nibName: String(describing: CategoriesCollectionViewCell.self),bundle: .main),
                                forCellWithReuseIdentifier: String(describing: CategoriesCollectionViewCell.self))
        
        collectionView.register(UINib(nibName: String(describing: BlogCollectionViewCell.self), bundle: .main),
                                forCellWithReuseIdentifier: String(describing: BlogCollectionViewCell.self))
        
        collectionView.register(UINib(nibName: String(describing: MainScreenHeaderView.self), bundle: .main),
                                forSupplementaryViewOfKind: MainScreenHeaderType.header.rawValue,
                                withReuseIdentifier: String(describing: MainScreenHeaderView.self))
    }
    
    func setLayout() {
        collectionView.collectionViewLayout = layout.createLayout()
    }
}
