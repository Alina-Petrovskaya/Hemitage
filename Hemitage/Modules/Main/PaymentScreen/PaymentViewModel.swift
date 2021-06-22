//
//  PaymentViewModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 22.06.2021.
//

import Foundation

protocol PaymentViewModelProtocol {
    func getSections() -> [DiffableSectionViewModel<PaymentSection>]
}

class PaymentViewModel: PaymentViewModelProtocol {
    
    private var cells: [PaymentCellViewModel] = [PaymentCellViewModel(), PaymentCellViewModel(), PaymentCellViewModel()]
    private let contentManager: some ReadContentManagerProtocol = ReadContentManager()
    
    init() {
        getCellsData()
    }
    
    
    private func getCellsData() {
        
    }
    
    
    func getSections() -> [DiffableSectionViewModel<PaymentSection>] {
        let sections: [DiffableSectionViewModel<PaymentSection>] = [DiffableSectionViewModel(type: .main, cells: cells)]
        
        return sections
    }
}
