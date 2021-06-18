//
//  UITableView.swift
//  Hemitage
//
//  Created by Vladislav Pavlenko on 18.06.2021.
//

import UIKit

extension UITableView {

    func dequeueReusableCell<Cell: UITableViewCell>(_ type: Cell.Type, for indexPath: IndexPath) -> Cell? {
        let identifier = String(describing: type)
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? Cell
    }

}
