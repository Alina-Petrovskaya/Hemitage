//
//  MainScreenViewController.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 05.05.2021.
//

import UIKit

class MainScreenViewController: UIViewController {
    
    enum TypeOfSection: Int, CaseIterable {
        case map, categories, blog
        
        var columnCount: Int {
            switch self {
            case .map:
                return 0
            case .categories:
                return 3
            case .blog:
                return 1
            }
        }
    }
    
    @IBOutlet private weak var songBottomView: TemplateSongView!
    @IBOutlet private weak var headerView: TemplateHeaderView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    
    var dataSource: MainScreenDatasource?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        pripareCollectionView()
    }
    
    private func pripareCollectionView() {
    
        collectionView.register(UINib(nibName: String(describing: MapCollectionViewCell.self), bundle: .main),
                                forCellWithReuseIdentifier: String(describing: MapCollectionViewCell.self))
        
        collectionView.register(UINib(nibName: String(describing: CategoriesCollectionViewCell.self),bundle: .main),
                                forCellWithReuseIdentifier: String(describing: CategoriesCollectionViewCell.self))
        
        collectionView.register(UINib(nibName: String(describing: BlogCollectionViewCell.self), bundle: .main),
                                forCellWithReuseIdentifier: String(describing: BlogCollectionViewCell.self))
        
        dataSource = MainScreenDatasource(with: collectionView)
        
        if let dataSource = dataSource {
            collectionView.collectionViewLayout = dataSource.createLayout()
            
            dataSource.setupDataSource()
            dataSource.reloadData()
        }
    }
}
