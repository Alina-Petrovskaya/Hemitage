//
//  DiffableSectionViewModel.swift
//  Hemitage
//
//  Created by Vladislav Pavlenko on 18.06.2021.
//

import Foundation

protocol DiffableSectionViewModelProtocol {
    
    associatedtype Section: Hashable
    
    var type: Section { get }
    var cells: [DiffableCellViewModel] { get }
    
}

class DiffableSectionViewModel<Section: Hashable>: DiffableSectionViewModelProtocol {
    
    var type: Section
    var cells: [DiffableCellViewModel]
    
    init(type: Section, cells: [DiffableCellViewModel]) {
        self.type = type
        self.cells = cells
    }
    
}
