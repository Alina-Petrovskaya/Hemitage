//
//  MainScreenDatasource.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 06.05.2021.
//

import UIKit

class MainScreenDatasource {
    
    enum TypeOfSection: Int, CaseIterable {
        case map, categories, blog
        
        var columnCount: Int {
            switch self {
            case .map:
                return 1
            case .categories:
                return 2
            case .blog:
                return 1
            }
        }
    }
    
    
    let collectionView: UICollectionView
    var dataSource: UICollectionViewDiffableDataSource<TypeOfSection, Int>! = nil
    
    
    init(with collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    
    // MARK: - Manage Data
    func reloadData() {
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
    
    
    func setupDataSource() {
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
        
        createHeader(for: dataSource)
        
    }
    
    private func configure<T: UICollectionViewCell>(cellType: T.Type, with intValue: Int, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: cellType), for: indexPath) as? T else {
            fatalError("Can't create cell with id \( String(describing: cellType) )")
        }
        return cell
    }
    
    
    private func createHeader(for datasource: UICollectionViewDiffableDataSource<TypeOfSection, Int>) {
        dataSource.supplementaryViewProvider = { collectionView, type, indexPath in
            guard let section = TypeOfSection(rawValue: indexPath.section) else { return nil }
            
            switch section {
            
            case .map:
                break
                
            case .categories:
                guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: headerType.categoriesHeader.rawValue,
                                                                                          withReuseIdentifier: String(describing: SectionHeader.self),
                                                                                          for: indexPath) as? SectionHeader else { return nil }
                sectionHeader.title.text = "Categories"
                
                return sectionHeader
                
            case .blog:
                guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: headerType.balogHeader.rawValue,
                                                                                          withReuseIdentifier: String(describing: SectionHeader.self),
                                                                                    for: indexPath) as? SectionHeader else { return nil }
                sectionHeader.title.text = "Blog"
                sectionHeader.button.isHidden = false
                
                return sectionHeader
            }
            
            return nil
        }
    }
    
    
    // MARK: - Setup dLayout
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            guard let sectionType =  TypeOfSection(rawValue: sectionIndex) else { return nil }
            
            switch sectionType {
            case .map:
                return self.generateMapSection()
                
            case .categories:
                let section = self.generateCategoriesSection()
                
                
                return section
                
            case .blog:
                return self.generateBlogSection()
            }
        }
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 20
        
        layout.configuration = configuration
        return layout
    }
    
    
    private func generateMapSection() -> NSCollectionLayoutSection {
        // item
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                                            widthDimension: .fractionalWidth(1),
                                            heightDimension: .estimated(40)))
        
        
        // Group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
                                                        widthDimension: .fractionalWidth(1),
                                                        heightDimension: .estimated(40)),
                                                       subitems: [item])
        
        //Section
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    
    private func generateCategoriesSection() -> NSCollectionLayoutSection {
        // item
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                                            widthDimension: .absolute(150),
                                            heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        
        // Group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
                                                        widthDimension: .fractionalWidth(5),
                                                        heightDimension: .absolute(150)),
                                                       subitems: [item])
        
        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: String(describing: SectionHeader.self) , alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    
    
    private func generateBlogSection() -> NSCollectionLayoutSection {
        // item
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                                            widthDimension: .fractionalWidth(1),
                                            heightDimension: .estimated(40)))
        
        // Group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
                                                        widthDimension: .fractionalWidth(1),
                                                        heightDimension: .estimated(40)),
                                                       subitems: [item])
        //Section
        let section = NSCollectionLayoutSection(group: group)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: String(describing: SectionHeader.self) , alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
}


