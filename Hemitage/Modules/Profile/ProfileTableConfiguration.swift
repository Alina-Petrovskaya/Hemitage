//
//  ProfileTableConfiguration.swift
//  Hemitage
//
//  Created by Vladislav Pavlenko on 18.06.2021.
//

import UIKit

enum ProfileSection {
    
    case main
    
}

class ProfileTableConfiguration: DiffableDataSourceConfiguration {
    
    typealias Section = ProfileSection
    
    var cellTypes: [UITableViewCell.Type] = [
        ProfileTableCell.self
    ]
    
    func provideCell(tableView: UITableView,
                     indexPath: IndexPath,
                     viewModel: DiffableCellViewModel) -> UITableViewCell? {
        
        switch viewModel.type {
        case .profile:
            guard let viewModel = viewModel as? ProfileTableCellViewModel,
                  let cell = tableView.dequeueReusableCell(ProfileTableCell.self, for: indexPath)
            else {
                return nil
            }
            
            cell.configure(with: viewModel)
            return cell
            
        default:
            return nil
        }
    }
    
}
