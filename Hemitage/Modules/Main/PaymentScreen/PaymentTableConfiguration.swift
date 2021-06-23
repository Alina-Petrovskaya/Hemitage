//
//  PaymentTableConfiguration.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 22.06.2021.
//

import UIKit

protocol PaymentTableConfigurationDelegate {
    
    func buyButtonTapped(viewModel: PaymentCellViewModel)
    
}

enum PaymentSection {
    case main
}

class PaymentTableConfiguration: DiffableDataSourceConfiguration {
    
    typealias Section = PaymentSection
    
    var cellTypes: [UITableViewCell.Type] = [PaymentCell.self]
    var delegate: PaymentTableConfigurationDelegate?
    
    func provideCell(tableView: UITableView, indexPath: IndexPath, viewModel: DiffableCellViewModel) -> UITableViewCell? {
        
        switch viewModel.type {
        case .payment:
            
            guard let viewModel = viewModel as? PaymentCellViewModel,
                  let cell = tableView.dequeueReusableCell(PaymentCell.self, for: indexPath)
            else {
                return nil
            }
            
            cell.configure(with: viewModel)
            cell.buyButtonTapped = { [weak self] in
                self?.delegate?.buyButtonTapped(viewModel: viewModel)
            }
            
            return cell
            
        default:
            return nil
        }
    }
    
}
