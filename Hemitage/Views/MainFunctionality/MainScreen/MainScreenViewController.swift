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
    
    var viewModel: MainScreenModelViewProtocol = MainScreenModelView()
    var dataSourceManager: MainScreenDataSourceManager?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        prepareViewModel()
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        
        registerNibs()
        createLayout()
        prepareDatasource()
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
    
    private func createLayout() {
        let layout = MainScreenLayoutConstructor()
        collectionView.collectionViewLayout = layout.createLayout()
    }
    
    private func prepareDatasource() {
        dataSourceManager = MainScreenDataSourceManager(with: collectionView)
        dataSourceManager?.headerCallBack = { print("Present blog VC") }
        
        dataSourceManager?.setupDataSource()
        dataSourceManager?.reloadData()
    }
    
    private func prepareViewModel() {
        collectionView.delegate = viewModel.collectionViewDelegate

        viewModel.userInteractionCallBack = { data in
            switch data {

            case .map(_):
                break

            case .category(_):
                print("Present group VC")

            case .blog(_):
                print("Present article detail VC")
            }
        }
    }
}
