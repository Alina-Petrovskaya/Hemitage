//
//  MainScreenDatasourceManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 06.05.2021.
//

import UIKit

class MainScreenDatasourceManager {
    
   
    
    
    let collectionView: UICollectionView
    var dataSource: UICollectionViewDiffableDataSource<MainScreenTypeOfSection, Int>! = nil
    
    
    init(with collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    
    // MARK: - Manage Data
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<MainScreenTypeOfSection, Int>()
        
        var itemOffset: Int = 0
        var itemUpperBound: Int? = nil
        
        MainScreenTypeOfSection.allCases.forEach { type in
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
    
    
    func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, intValue in
            guard let section = MainScreenTypeOfSection(rawValue: indexPath.section) else { return UICollectionViewCell() }
            
            switch section {
            case .map:
                return self.configure(cellType: MapCollectionViewCell.self, with: intValue, for: indexPath)
                
            case .categories:
                return self.configure(cellType: CategoriesCollectionViewCell.self, with: intValue, for: indexPath)
                
            case .blog:
               return self.configure(cellType: BlogCollectionViewCell.self, with: intValue, for: indexPath)
            }
        })
        
        createHeader(for: dataSource)
        
    }
    
    private func configure<T: UICollectionViewCell>(cellType: T.Type, with intValue: Int, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: cellType), for: indexPath) as? T else {
            fatalError("Can't create cell with id \( String(describing: cellType) )")
        }
        return cell
    }
    
    
    private func createHeader(for datasource: UICollectionViewDiffableDataSource<MainScreenTypeOfSection, Int>) {
        dataSource.supplementaryViewProvider = { collectionView, type, indexPath in
            guard let section = MainScreenTypeOfSection(rawValue: indexPath.section),
                  let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: MainScreenHeaderType.categoriesHeader.rawValue,
                                                                                      withReuseIdentifier: String(describing: SectionHeader.self),
                                                                                      for: indexPath) as? SectionHeader
            else { return nil }
            
            
            switch section {
            
            case .map:
                break
                
            case .categories:
                sectionHeader.title.text = "Categories"
            
                return sectionHeader
                
            case .blog:
                sectionHeader.title.text = "Blog"
                sectionHeader.button.isHidden = false
                
                return sectionHeader
            }
            
            return nil
        }
    }
    
    
    // MARK: - Setup dLayout

}


