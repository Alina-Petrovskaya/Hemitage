//
//  GroupScreenTableViewDatasource.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 07.06.2021.
//

import UIKit

class GroupScreenTableViewDatasource: GroupScreenDataSourceProtocol {
    
    private var dataSource: UITableViewDiffableDataSource<Int, ViewModelTemplateSong>?
    private var groupScreenDelegate: GroupScreenTableDelegateProtocol
    
    
    init(with tableView: UITableView) {
        groupScreenDelegate = GroupScreenTableViewDelegate(with: tableView)
        setupDataSource(with: tableView)
    }
    
    func getDelegateObject<T>() -> T? {
        return groupScreenDelegate as? T
    }
    
    // MARK: - Data Updating
    func insertItems<T: ViewModelConfigurator>(items: [T]) {
        guard var snapshot = dataSource?.snapshot(),
              let data = items as? [ViewModelTemplateSong] else { return }

        snapshot.appendItems(data)
        dataSource?.apply(snapshot, animatingDifferences: true)
        
        if data.count > 0 {
            groupScreenDelegate.canLoadMoreData = true
        }
        
        groupScreenDelegate.tableView.tableFooterView = nil
    }
    
    
    func reloadItems<T: ViewModelConfigurator>(data: T, with index: Int) {
    }
    
    
    func deleteItems<T: ViewModelConfigurator>(items: [T]) {
    }
    
    
    // MARK: - Prepare data to display
    func reloadData<T: GroupScreenViewModelProtocol>(with viewModel: T) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, ViewModelTemplateSong>()
        
        snapshot.appendSections([0])
        
        if let items: [ViewModelTemplateSong] = viewModel.getDataContent(for: .songList) {
            snapshot.appendItems(items, toSection: 0)
            
            if items.count > 0 {
                groupScreenDelegate.canLoadMoreData = true
                groupScreenDelegate.tableView.tableFooterView = nil
            }
        }
        
        
        DispatchQueue.main.async { [weak self] in
            self?.dataSource?.defaultRowAnimation = .fade
            self?.dataSource?.apply(snapshot, animatingDifferences: true)
        }
    }
    
    
    private func setupDataSource(with tableView: UITableView) {
        dataSource = UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, model in
            let cellID = String(describing: GroupScreenSongCell.self)
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? GroupScreenSongCell
            else {
                fatalError("Can't create cell with id \(cellID)")
            }
            
            cell.updateContent(with: model)
            return cell
        }
    }
}
