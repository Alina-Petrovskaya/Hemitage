//
//  MainScreenLayoutConstructor.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 08.05.2021.
//

import UIKit

protocol MainScreenLayoutConstructorProtocol {
    
    func createLayout() -> UICollectionViewLayout
    
}

struct MainScreenLayoutConstructor: MainScreenLayoutConstructorProtocol {
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            guard let sectionType =  MainScreenTypeOfSection(rawValue: sectionIndex) else { return nil }
            
            switch sectionType {
            case .map:
                return generateMapSection()
                
            case .categories:
                return generateCategoriesSection()
                
            case .blog:
                return generateBlogSection()
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
                                            widthDimension: .fractionalWidth(0.09),
                                            heightDimension: .fractionalWidth(0.091)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        
        // Group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
                                                        widthDimension: .fractionalWidth(5),
                                                        heightDimension: .estimated(40)),
                                                       subitems: [item])
        
        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: String(describing: MainScreenHeaderView.self) , alignment: .top)
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
        let section    = NSCollectionLayoutSection(group: group)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(80))
        let header     = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                     elementKind: String(describing: MainScreenHeaderView.self),
                                                                     alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
}
