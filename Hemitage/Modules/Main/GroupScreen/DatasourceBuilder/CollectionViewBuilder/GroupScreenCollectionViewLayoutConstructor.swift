//
//  GroupScreenCollectionViewLayoutConstructor.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 02.06.2021.
//

import UIKit

class GroupScreenCollectionViewLayoutConstructor {
    
    func createLayout() -> UICollectionViewLayout {
        return  UICollectionViewCompositionalLayout(section: generateSubGroubSection())
    }
    
    private func generateSubGroubSection() -> NSCollectionLayoutSection {
        // item
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                                            widthDimension: .estimated(100),
                                            heightDimension: .fractionalHeight(0.7)))
        
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: nil, trailing: .flexible(10), bottom: nil)
        
        // Group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
                                                        widthDimension: .fractionalWidth(10),
                                                        heightDimension: .fractionalHeight(1)),
                                                       subitems: [item])
 
        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
       

        return section
    }
}
