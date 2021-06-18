//
//  DiffableDataSourceConfiguration.swift
//  Hemitage
//
//  Created by Vladislav Pavlenko on 18.06.2021.
//

import UIKit

protocol DiffableDataSourceConfiguration {
    
    associatedtype Section: Hashable
    
    var cellTypes: [UITableViewCell.Type] { get }
    
    func provideCell(tableView: UITableView,
                     indexPath: IndexPath,
                     viewModel: DiffableCellViewModel) -> UITableViewCell?
    
}
