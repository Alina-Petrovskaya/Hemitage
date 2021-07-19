//
//  PaymentController.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 09.06.2021.
//

import UIKit

class PaymentController: UIViewController, ResultObserver {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSourceManager: DiffableDataSourceManager<PaymentTableConfiguration>!
    private var viewModel: PaymentViewModelProtocol & PaymentTableConfigurationDelegate & ResultProtocol = PaymentViewModel()
    
    var kvoSuccess: NSKeyValueObservation?
    var kvoError: NSKeyValueObservation?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 65 //whatever number
        self.tableView.rowHeight = UITableView.automaticDimension

        
        let configuration      = PaymentTableConfiguration()
        configuration.delegate = viewModel
        dataSourceManager      = DiffableDataSourceManager(configuration: configuration)
        
        tableView.dataSource   = dataSourceManager.provideDataSource(for: tableView)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let sections = viewModel.getSections()
        dataSourceManager.update(sections: sections)
    }
    
    
}
