//
//  MainScreenViewController.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 05.05.2021.
//

import UIKit

class MainScreenViewController: UIViewController {

    @IBOutlet private weak var songBottomView: TemplateSongView!
    @IBOutlet private weak var headerView: TemplateHeaderView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    
    var dataSource: DataSourceManagerMainScreen?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        registerNibs()
        prepareCollectionView()
    }
   
    
    private func prepareCollectionView() {
        dataSource = DataSourceManagerMainScreen(with: collectionView)
        let layout = LayoutConstructorMainScreen()
        
        collectionView.collectionViewLayout = layout.createLayout()
        
        dataSource?.setupDataSource()
        dataSource?.reloadData()
        
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
