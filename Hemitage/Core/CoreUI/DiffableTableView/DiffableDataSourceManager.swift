//
//  DiffableTableView.swift
//  Hemitage
//
//  Created by Vladislav Pavlenko on 18.06.2021.
//

import UIKit

class DiffableDataSourceManager<Configuration: DiffableDataSourceConfiguration> {
    
    typealias Section = Configuration.Section
    typealias DataSource = UITableViewDiffableDataSource<Section, DiffableCellViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, DiffableCellViewModel>
    
    var configuration: Configuration
    var dataSource: DataSource?
    
    init(configuration: Configuration) {
        self.configuration = configuration
    }
    
    private func registerCells(in tableView: UITableView) {
        for cellType in configuration.cellTypes {
            let identifier = String(describing: cellType)
            let nib = UINib(nibName: identifier, bundle: .main)
            tableView.register(nib, forCellReuseIdentifier: identifier)
        }
    }
    
    func provideDataSource(for tableView: UITableView) -> DataSource {
        registerCells(in: tableView)
        
        let dataSource = DataSource(tableView: tableView, cellProvider: configuration.provideCell)
        
        self.dataSource = dataSource
        return dataSource
    }
    
    func update(sections: [DiffableSectionViewModel<Section>]) {
        var snapshot = Snapshot()
        
        for section in sections {
            snapshot.appendSections([section.type])
            snapshot.appendItems(section.cells, toSection: section.type)
        }

        DispatchQueue.main.async { [weak self] in
            self?.dataSource?.apply(snapshot, animatingDifferences: true)
        }
        
    }
    
}
