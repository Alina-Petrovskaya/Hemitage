//
//  GroupScreenTableViewBuilder.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 02.06.2021.
//

import UIKit

class GroupScreenTableViewBuilder: GroupScreenBuilder {
    
    func setLayout(for object: UIScrollView) {
       
    }
    
    
    func registerNibs(for object: UIScrollView) {
        guard let tableView = object as? UITableView else { return }
        
        let cellID = String(describing: GroupScreenSongCell.self)
        let headerID = String(describing: GroupScreenHeaderView.self)
        
        tableView.register(UINib(nibName: cellID, bundle: .main), forCellReuseIdentifier: cellID)
        tableView.register(UINib(nibName: headerID, bundle: .main), forHeaderFooterViewReuseIdentifier: headerID)
    }
    
    
    func setupDataSource<T: GroupScreenViewModelProtocol>(for object: UIScrollView, with viewModel: T) -> GroupScreenDataSourceProtocol?  {
        guard let tableView = object as? UITableView else { return nil }
        
        let dataSource: GroupScreenDataSourceProtocol = GroupScreenTableViewDatasource(with: tableView)
        dataSource.reloadData(with: viewModel)
        
        return dataSource
    }
    
}
