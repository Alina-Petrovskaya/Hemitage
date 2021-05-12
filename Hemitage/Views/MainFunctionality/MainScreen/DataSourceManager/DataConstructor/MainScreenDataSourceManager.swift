//
//  MainScreenDataSourceManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 06.05.2021.
//

import UIKit

protocol MainScreenDataSourceManagerProtocol {
    
    var dataSource: UICollectionViewDiffableDataSource<MainScreenTypeOfSection, MainScreenModelWrapper>? { get set }

    func createHeader(with view: MainScreenHeaderView, at indexPath: IndexPath ) -> MainScreenHeaderView?
    func reloadData()
    
}


class MainScreenDataSourceManager: MainScreenDataSourceManagerProtocol {
    private let dataManager = MainScreenDataManager()
    var dataSource: UICollectionViewDiffableDataSource<MainScreenTypeOfSection, MainScreenModelWrapper>? = nil
    
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<MainScreenTypeOfSection, MainScreenModelWrapper>()
        
        snapshot.appendSections(MainScreenTypeOfSection.allCases)
        
        MainScreenTypeOfSection.allCases.forEach { type in
            snapshot.appendItems(dataManager.getSectionContent(for: type), toSection: type)
        }
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    
    func createHeader(with view: MainScreenHeaderView, at indexPath: IndexPath ) -> MainScreenHeaderView? {
        guard let section = MainScreenTypeOfSection(rawValue: indexPath.section) else { return nil }
        
        switch section {
        case .map:
            break
            
        case .categories:
            view.categoryName.text = "Categories"
            
            return view
            
        case .blog:
            view.categoryName.text = "Blog"
            view.categoryButton.isHidden = false
            
            return view
        }
        
        return nil
    }
}


