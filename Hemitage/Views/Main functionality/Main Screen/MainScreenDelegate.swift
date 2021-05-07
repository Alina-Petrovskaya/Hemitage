//
//  MainScreenDelegate.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 06.05.2021.
//

import UIKit

class MainScreenDelegate {
    
    enum TypeOfSection: Int, CaseIterable {
        case map, categories, blog
        
        var columnCount: Int {
            switch self {
            case .map:
                return 1
            case .categories:
                return 3
            case .blog:
                return 1
            }
        }
    }
    
    
    func createLayout() -> UICollectionViewLayout {
        let layout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            guard let sectionType =  TypeOfSection(rawValue: sectionIndex) else { return nil }
            
            switch sectionType {
            case .map:
                return self.generateMapLayout()
            case .categories:
                return self.generateCategoriesLayout()
            case .blog:
                return self.generateBlogLayout()
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        
        layout.configuration = config
        return layout
    }
    
    
    private func generateMapLayout() -> NSCollectionLayoutSection {
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
    
    
    private func generateCategoriesLayout() -> NSCollectionLayoutSection {
        // item
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                                            widthDimension: .absolute(150),
                                            heightDimension: .absolute(163)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        
        // Group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
                                                        widthDimension: .fractionalWidth(5),
                                                        heightDimension: .absolute(163)),
                                                       subitems: [item])
        
        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    
    
    private func generateBlogLayout() -> NSCollectionLayoutSection {
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
    
}


