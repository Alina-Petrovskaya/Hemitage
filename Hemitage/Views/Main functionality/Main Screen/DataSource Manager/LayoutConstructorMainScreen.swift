//
//  LayoutConstructorMainScreen.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 08.05.2021.
//

import UIKit

struct LayoutConstructorMainScreen {
    func generateMapSection() -> NSCollectionLayoutSection {
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
    
    
     func generateCategoriesSection() -> NSCollectionLayoutSection {
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
    
    
    
     func generateBlogSection() -> NSCollectionLayoutSection {
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
                                                                     elementKind: String(describing: SectionHeader.self),
                                                                     alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
}
