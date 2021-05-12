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
    var dataSourceManager: MainScreenDataSourceManagerProtocol = MainScreenDataSourceManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        prepareViewModel()
        registerNibs()
        createLayout()
        setupDataSource()
        dataSourceManager.reloadData()
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
    
    // MARK: - Manage Data
    private func setupDataSource() {
        dataSourceManager.dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView,
                                                                          cellProvider: { [weak self] collectionView, indexPath, model in
            
            guard let section = MainScreenTypeOfSection(rawValue: indexPath.section) else { return UICollectionViewCell()}
            
            switch section {
            case .map:
                return self?.configure(cellType: MapCollectionViewCell.self, with: model, for: indexPath)
                
            case .categories:
                return self?.configure(cellType: CategoriesCollectionViewCell.self, with: model, for: indexPath)
                
            case .blog:
                return self?.configure(cellType: BlogCollectionViewCell.self, with: model, for: indexPath)
            }
        })
        
        createHeader()
    }
    
    
    private func configure<T: ConfiguringCell>(cellType: T.Type,
                                               with model: MainScreenModelWrapper,
                                               for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: cellType), for: indexPath) as? T else {
            fatalError("Can't create cell with id \( String(describing: cellType))")
        }
        
        cell.updateContent(with: model)
        return cell
    }
    
    
    private func createHeader() {
        dataSourceManager.dataSource?.supplementaryViewProvider = { [weak self] collectionView, type, indexPath in
            
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: MainScreenHeaderType.header.rawValue,
                                                                                      withReuseIdentifier: String(describing: MainScreenHeaderView.self),
                                                                                      for: indexPath) as? MainScreenHeaderView
            else { return nil }
            sectionHeader.callBack = { print("Present blog VC") }
            
            return self?.dataSourceManager.createHeader(with: sectionHeader, at: indexPath)
        }
    }
}
