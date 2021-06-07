//
//  GroupScreenTableViewDatasource.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 07.06.2021.
//

import UIKit

class GroupScreenTableViewDatasource: GroupScreenDataSourceProtocol {
    
    private var tableView: UITableView
    private var dataSource: UITableViewDiffableDataSource<Int, ViewModelTemplateSong>?
    
    init(with tableView: UITableView) {
        self.tableView = tableView
        
        setupDataSource()
    }
    
    
    // MARK: - Data Updating
    func insertItems<T: ViewModelConfigurator>(items: [T]) {
        guard var snapshot = dataSource?.snapshot(),
              let data = items as? [ViewModelTemplateSong] else { return }

        snapshot.appendItems(data)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    
    func reloadItems<T: ViewModelConfigurator>(data: T, with index: Int) {
        guard var snapshot = dataSource?.snapshot(),
              let item = data as? ViewModelTemplateSong else { return }

        let itemForReload = snapshot.itemIdentifiers[index]
        itemForReload.setData(with: item.getData())

        snapshot.reloadItems([itemForReload])
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    
    func deleteItems<T: ViewModelConfigurator>(items: [T]) {
        guard var snapshot = dataSource?.snapshot(),
              let data = items as? [ViewModelTemplateSong] else { return }

        snapshot.deleteItems(data)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    
    // MARK: - Prepare data to display
    func reloadData<T: GroupScreenViewModelProtocol>(with viewModel: T) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, ViewModelTemplateSong>()
        
        snapshot.appendSections([0])
        
        if let items: [ViewModelTemplateSong] = viewModel.getDataContent(for: .songList) {
            snapshot.appendItems(items, toSection: 0)
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.dataSource?.apply(snapshot, animatingDifferences: true)
        }
    }
    
    
   
    private func setupDataSource() {
        
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = GroupScreenHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        
        return view
    }
    
    
    
}
