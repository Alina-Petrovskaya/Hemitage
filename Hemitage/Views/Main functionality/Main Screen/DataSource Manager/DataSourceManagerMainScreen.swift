//
//  DataSourceManagerMainScreen.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 06.05.2021.
//

import UIKit

class DataSourceManagerMainScreen {
    
    private let collectionView: UICollectionView
    private var dataSource: UICollectionViewDiffableDataSource<MainScreenTypeOfSection, MainScreenModelWrapper>! = nil
    private let viewModel: MainScreenModelViewProtocol = MainScreenViewModel()
    
    
    init(with collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    
    // MARK: - Manage Data
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<MainScreenTypeOfSection, MainScreenModelWrapper>()
        
        snapshot.appendSections(MainScreenTypeOfSection.allCases)
        
        MainScreenTypeOfSection.allCases.forEach { type in
            
            snapshot.appendItems(viewModel.getSectionContent(for: type), toSection: type)
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    
    func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, model in
            guard let section = MainScreenTypeOfSection(rawValue: indexPath.section) else { return UICollectionViewCell() }
            
            switch section {
            case .map:
                return self.configure(cellType: MapCollectionViewCell.self, with: model, for: indexPath)
                
            case .categories:
                return self.configure(cellType: CategoriesCollectionViewCell.self, with: model, for: indexPath)
                
            case .blog:
               return self.configure(cellType: BlogCollectionViewCell.self, with: model, for: indexPath)
            }
        })
        
        createHeader(for: dataSource)
        
    }
    
    private func configure<T: ConfiguringCell>(cellType: T.Type, with model: MainScreenModelWrapper, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: cellType), for: indexPath) as? T else {
            fatalError("Can't create cell with id \( String(describing: cellType))")
        }
        
        cell.updateContent(with: model)
        return cell
    }
    
    
    private func createHeader(for datasource: UICollectionViewDiffableDataSource<MainScreenTypeOfSection, MainScreenModelWrapper>) {
        dataSource.supplementaryViewProvider = { [weak self] collectionView, type, indexPath in
            
            guard let section = MainScreenTypeOfSection(rawValue: indexPath.section),
                  let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: MainScreenHeaderType.header.rawValue,
                                                                                      withReuseIdentifier: String(describing: MainScreenHeaderView.self),
                                                                                      for: indexPath) as? MainScreenHeaderView
            else { return nil }
            
            return self?.viewModel.getHeaderView(for: sectionHeader, at: section)
        }
    }
}


