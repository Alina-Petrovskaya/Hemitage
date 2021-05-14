//
//  MainScreenDataSourceManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 06.05.2021.
//

import UIKit

protocol MainScreenDataSourceManagerProtocol {
    
    var headerCallback: (() -> ())? { get set }
    
    func reloadData(with viewModel: MainScreenViewModelProtocol)
    
    func insertItems(items: [MainScreenModelWrapper], at section: MainScreenTypeOfSection)
    func reloadItems(items: [MainScreenModelWrapper])
    func deleteItems(items: [MainScreenModelWrapper])
}


class MainScreenDataSourceManager: MainScreenDataSourceManagerProtocol {
    
    private var collectionView: UICollectionView
    private var dataSource: UICollectionViewDiffableDataSource<MainScreenTypeOfSection, MainScreenModelWrapper>?
    
    var headerCallback: (() -> ())?
    
    
    init(with collectionView: UICollectionView) {
        self.collectionView = collectionView
    
        setupDataSource()
    }
    
    
    func reloadData(with viewModel: MainScreenViewModelProtocol) {
        var snapshot = NSDiffableDataSourceSnapshot<MainScreenTypeOfSection, MainScreenModelWrapper>()
        
        snapshot.appendSections(MainScreenTypeOfSection.allCases)
        
        MainScreenTypeOfSection.allCases.forEach { type in
            snapshot.appendItems(viewModel.getSectionContent(for: type), toSection: type)
        }
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    
    func insertItems(items: [MainScreenModelWrapper], at section: MainScreenTypeOfSection) {
        guard var snapshot = dataSource?.snapshot() else { return }
        
        switch section {
        case .map:
            break
           
        case .categories:
            snapshot.appendItems(items, toSection: section)
            
        case .blog:
            let firstItem = snapshot.itemIdentifiers(inSection: section)[0]
            snapshot.insertItems(items, beforeItem: firstItem)
        }
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    
    func reloadItems(items: [MainScreenModelWrapper]) {
        guard var snapshot = dataSource?.snapshot() else { return }
        
        snapshot.reloadItems(items)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    
    func deleteItems(items: [MainScreenModelWrapper]) {
        guard var snapshot = dataSource?.snapshot() else { return }
        snapshot.deleteItems(items)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { [weak self] collectionView, indexPath, model in
            
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
        dataSource?.supplementaryViewProvider = { collectionView, type, indexPath in
            guard let section = MainScreenTypeOfSection(rawValue: indexPath.section),
                  let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: MainScreenHeaderType.header.rawValue,
                                                                                      withReuseIdentifier: String(describing: MainScreenHeaderView.self),
                                                                                      for: indexPath) as? MainScreenHeaderView
            else { return nil }
            
            sectionHeader.callBack = { [weak self] in
                self?.headerCallback?()
            }
            
            switch section {
            case .map:
                break
                
            case .categories:
                sectionHeader.categoryName.text = "Categories"
                
                return sectionHeader
                
                
            case .blog:
                sectionHeader.categoryName.text = "Blog"
                sectionHeader.categoryButton.isHidden = false
                
                return sectionHeader
            }
            
            return sectionHeader
        }
    }
}


