//
//  GroupScreenCollectionViewDatasource.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 02.06.2021.
//

import UIKit

class GroupScreenCollectionViewDatasource: GroupScreenDataSourceProtocol {
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, GroupScreenSubgroupCellViewModel>?
    private var groupScreenDelegate: GroupScreenCollectionDelegateProtocol
    
    
    init(with collectionView: UICollectionView) {
        groupScreenDelegate = GroupScreenCollectionViewDelegate(with: collectionView)
        setupDataSource()
    }
    
    
    func getDelegateObject<T>() -> T? {
        return groupScreenDelegate as? T
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
        
        itemForReload.setData(with: item.getData())
        
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
        
        
            if let items: [GroupScreenSubgroupCellViewModel] = viewModel.getDataContent(for: .subGroup) {
                snapshot.appendItems(items, toSection: 0)
            }
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    
   
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, GroupScreenSubgroupCellViewModel>(collectionView: groupScreenDelegate.collectionView) { collectionView, indexPath, model in
            let cellId = String(describing: GroupScreenSubgroupCell.self)
            
            
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? GroupScreenSubgroupCell else {
                fatalError("Can't create cell with id \(cellId)")
            }
            cell.updateContent(with: model)
            
            
            return cell
            
        }
    }

}
