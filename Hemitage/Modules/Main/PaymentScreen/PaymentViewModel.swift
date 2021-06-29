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

class PaymentViewModel: NSObject, PaymentViewModelProtocol, PaymentTableConfigurationDelegate, ResultProtocol {
   
    private var cells: [PaymentCellViewModel] = []
    private var contentManager: ReadContentManagerProtocol = ReadContentManager()
    private var userManager: FireStoreUserManagerProtocol  = FireStoreUserManager()
    
    @objc dynamic private(set) var sucssesResult: String?
    @objc dynamic private(set) var errorMessage: String?
    
    override init() {
        super.init()
        
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
        
        
        userManager.getUserData { [weak self] model in
            if viewModel.getID() == model.id, model.subscriptionExpirationDate < Date() {
                self?.errorMessage = IAPError.alreadySubscribed.localizedDescription
                
                
            } else  {
                guard let product = Products(rawValue: viewModel.getID())
                else { return }
                
                IAPManager.shared.purchase(product: product)
                
            }
        }
        

    }
    
    
    private func checkSubscriptionStatus() {
        // Get the receipt if it's available
        if let appStoreReceiptURL = Bundle.main.appStoreReceiptURL,
            FileManager.default.fileExists(atPath: appStoreReceiptURL.path) {

            do {
                let receiptData = try Data(contentsOf: appStoreReceiptURL, options: .alwaysMapped)
                print(receiptData)

                let receiptString = receiptData.base64EncodedString(options: [])
                
                print(receiptString)
            }
            catch { print("Couldn't read receipt data with error: " + error.localizedDescription) }
        }
    }
}
