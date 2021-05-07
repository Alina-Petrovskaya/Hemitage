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
    
    
    let mainScreenDelegate = MainScreenDelegate()
    
    var dataSource: UICollectionViewDiffableDataSource<TypeOfSection, Int>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        pripareCollectionView()
    }
    
    private func pripareCollectionView() {
        
        collectionView.collectionViewLayout = mainScreenDelegate.createLayout()
        
        collectionView.register(UINib(nibName: Constants.shared.mapCell, bundle: .main), forCellWithReuseIdentifier: Constants.shared.mapCell)
        collectionView.register(UINib(nibName: Constants.shared.categoriesCell, bundle: .main), forCellWithReuseIdentifier: Constants.shared.categoriesCell)
        collectionView.register(UINib(nibName: Constants.shared.blogCell, bundle: .main), forCellWithReuseIdentifier: Constants.shared.blogCell)
        
        setupDataSource()
        reloadData()
        
    }
    
    private func configure<T: SelfConfiguringCell>(cellType: T.Type, with intValue: Int, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: cellType), for: indexPath) as? T else {
            fatalError("Cant create cell with id \( String(describing: cellType) )")
        }
        return cell
    }
    
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<TypeOfSection, Int>()
        
        var itemOffset: Int = 0
        var itemUpperBound: Int? = nil
        
        TypeOfSection.allCases.forEach { type in
            switch type {
            case .map:
                itemOffset     = type.columnCount * 0
                itemUpperBound = itemOffset + 0
                
            case .categories:
                 itemOffset     = type.columnCount * 4
                 itemUpperBound = itemOffset + 4
                
            case .blog:
                itemOffset     = type.columnCount * 2
                itemUpperBound = itemOffset + 2
            }
            
            snapshot.appendSections([type])
            
            if let itemUpperBound = itemUpperBound {
                snapshot.appendItems(Array(itemOffset...itemUpperBound))
            }
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, intValue in
            guard let section = TypeOfSection(rawValue: indexPath.section) else { return UICollectionViewCell() }
            
            switch section {
            case .map:
                return self.configure(cellType: MapCollectionViewCell.self, with: intValue, for: indexPath)
                
            case .categories:
                return self.configure(cellType: CategoriesCollectionViewCell.self, with: intValue, for: indexPath)
                
            case .blog:
                return self.configure(cellType: BlogCollectionViewCell.self, with: intValue, for: indexPath)
            }
        })
    }
    
    func configure() {
        
    }
    
    
}
