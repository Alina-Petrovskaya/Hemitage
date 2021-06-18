//
//  ProfileController.swift
//  Hemitage
//
//  Created by Vladislav Pavlenko on 18.06.2021.
//

import UIKit

class ProfileController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSourceManager: DiffableDataSourceManager<ProfileTableConfiguration>!
    
    let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configuration = ProfileTableConfiguration()
        dataSourceManager = DiffableDataSourceManager(configuration: configuration)
        
        tableView.dataSource = dataSourceManager.provideDataSource(for: tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let cells = [ProfileTableCellViewModel(), ProfileTableCellViewModel(), ProfileTableCellViewModel(), ProfileTableCellViewModel(), ProfileTableCellViewModel(), ProfileTableCellViewModel(), ProfileTableCellViewModel(), ProfileTableCellViewModel(), ProfileTableCellViewModel(), ProfileTableCellViewModel(), ProfileTableCellViewModel(), ProfileTableCellViewModel(), ProfileTableCellViewModel(), ProfileTableCellViewModel(), ProfileTableCellViewModel()]
        let sections: [DiffableSectionViewModel<ProfileSection>] = [
            DiffableSectionViewModel(type: .main, cells: cells)
        ]
        
        dataSourceManager.update(sections: sections)
    }

}
