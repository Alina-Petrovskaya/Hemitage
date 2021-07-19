//
//  DiffableCellViewModel.swift
//  Hemitage
//
//  Created by Vladislav Pavlenko on 18.06.2021.
//

import Foundation

protocol DiffableCellViewModelProtocol: Hashable {
    
    var type: TableCellType { get }
    
}

class DiffableCellViewModel: DiffableCellViewModelProtocol {
    
    var type: TableCellType { .none }
    
    static func == (lhs: DiffableCellViewModel, rhs: DiffableCellViewModel) -> Bool {
        lhs.type == rhs.type
    }

    
    func hash(into hasher: inout Hasher) {
        hasher.combine(type)
    }
    
}
