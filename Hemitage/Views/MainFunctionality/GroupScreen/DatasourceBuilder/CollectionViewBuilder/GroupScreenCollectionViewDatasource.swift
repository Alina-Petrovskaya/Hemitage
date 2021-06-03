//
//  GroupScreenCollectionViewDatasource.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 02.06.2021.
//

import UIKit

class GroupScreenCollectionViewDatasource: GroupScreenDataSourceProtocol {
    
    private var collectionView: UICollectionView
    private var dataSource: UICollectionViewDiffableDataSource<Int, GroupScreenSubgroupCellViewModel>?
    
    init(with collectionView: UICollectionView) {
        self.collectionView = collectionView
        
        setupDataSource()
    }
    
    
    // MARK: - Data Updating
    func insertItems<T: ViewModelConfigurator>(items: [T]) {
        guard var snapshot = dataSource?.snapshot(),
              let data = items as? [GroupScreenSubgroupCellViewModel] else { return }

        snapshot.appendItems(data)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    
    func reloadItems<T: ViewModelConfigurator>(data: T, with index: Int) {
        guard var snapshot = dataSource?.snapshot(),
              let item = data as? GroupScreenSubgroupCellViewModel else { return }
         
        let itemForReload = snapshot.itemIdentifiers[index]
      
//         itemForReload.setData(with: item)
        
        snapshot.reloadItems([itemForReload])
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    
    func deleteItems<T: ViewModelConfigurator>(items: [T]) {
        guard var snapshot = dataSource?.snapshot(),
              let data = items as? [GroupScreenSubgroupCellViewModel] else { return }
        
        snapshot.deleteItems(data)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    
    // MARK: - Prepare data to display
    func reloadData<T: GroupScreenViewModelProtocol>(with viewModel: T) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, GroupScreenSubgroupCellViewModel>()
        snapshot.appendSections([0])
        
//        snapshot.appendItems([])
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    
   
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, model in
            
            let cellId = String(describing: GroupScreenSubgroupCell.self)
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? GroupScreenSubgroupCell else {
                fatalError("Can't create cell with id \(cellId)")
            }
            
//            cell.updateContent(with: model)
            
            return cell
            
            
        }
    }

}
