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

class PaymentViewModel: PaymentViewModelProtocol, PaymentTableConfigurationDelegate {
   
    private var cells: [PaymentCellViewModel] = []
    private var contentManager: some ReadContentManagerProtocol = ReadContentManager()
    
    
    init() {
        getCellsData()
    }
    
    
    private func getCellsData() {
        contentManager.callback = { [weak self] result in
            guard let data = result.data as? [PaymentModel] else { return }
            
            switch result.typeOfChange {
            case .added:
                 data.forEach { data in
                    self?.cells.append(PaymentCellViewModel(with: data))
                }
            
            default:
                break
            }
        }
        
        contentManager.getContent(from: .products, with: .fireBaseManager, codableModel: PaymentModel.self)
    }
    
    
    func getSections() -> [DiffableSectionViewModel<PaymentSection>] {
        let sections: [DiffableSectionViewModel<PaymentSection>] = [DiffableSectionViewModel(type: .main, cells: cells)]
        
        return sections
    }
    
    
    func buyButtonTapped(viewModel: PaymentCellViewModel) {
        print("Buy button tapped")
    }
}
