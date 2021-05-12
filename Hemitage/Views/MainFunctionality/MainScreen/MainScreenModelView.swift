//
//  MainScreenModelView.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 12.05.2021.
//

import UIKit

protocol MainScreenModelViewProtocol {

    var userInteractionCallBack: ((MainScreenModelWrapper) -> ())? { get set }
    var headerCallBack: (() -> ())? { get set }
    
    init(with collectionView: UICollectionView)
}

final class MainScreenModelView: MainScreenModelViewProtocol {
    var headerCallBack: (() -> ())?
    var userInteractionCallBack: ((MainScreenModelWrapper) -> ())?
    var dataSource: DataSourceManagerMainScreen?
    let collectionView: UICollectionView
    let collectionViewDelegate = CollectionViewMainScreenDelegate()
    
    
    init(with collectionView: UICollectionView) {
        self.collectionView = collectionView
        
        registerNibs()
        createLayout()
        configureCollectionView()
        
        collectionView.delegate = collectionViewDelegate
        
        collectionViewDelegate.callBack = { [weak self] data in
            self?.userInteractionCallBack?(data)
        }
    }
    
    private func createLayout() {
        let layout = LayoutConstructorMainScreen()
        
        collectionView.collectionViewLayout = layout.createLayout()
    }
    
    
    private func configureCollectionView() {
        dataSource = DataSourceManagerMainScreen(with: collectionView)
            
        dataSource?.setupDataSource()
        dataSource?.reloadData()
        
        dataSource?.headerCallBack = { [weak self] in
            self?.headerCallBack?()
        }
    }
    
    
    private func registerNibs() {
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
}
