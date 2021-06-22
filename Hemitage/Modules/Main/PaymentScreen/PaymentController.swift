//
//  PaymentController.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 09.06.2021.
//

import UIKit

class PaymentController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var dataSourceManager: DiffableDataSourceManager<PaymentTableConfiguration>!
    private var viewModel: PaymentViewModelProtocol = PaymentViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configuration = PaymentTableConfiguration()
        dataSourceManager = DiffableDataSourceManager(configuration: configuration)
        
        tableView.dataSource = dataSourceManager.provideDataSource(for: tableView)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let sections = viewModel.getSections()
        dataSourceManager.update(sections: sections)
    }

}
