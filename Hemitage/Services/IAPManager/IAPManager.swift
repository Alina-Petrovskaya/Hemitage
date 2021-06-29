//
//  IAPManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 23.06.2021.
//

import Foundation
import StoreKit

protocol IAPManagerProtocol {
    
    func fetchProducts()
    func purchase(product: Products )
    
}

class IAPManager: NSObject, IAPManagerProtocol, SKProductsRequestDelegate, SKPaymentTransactionObserver {
 
    static let shared: IAPManagerProtocol = IAPManager()
    var callback: ((Result<String, Error>) -> ())?
    private var products: [SKProduct] = []
    
    
    private override init() {
        super.init()
    }
    
    
    func fetchProducts() {
        let request = SKProductsRequest(productIdentifiers: Set(Products.allCases.compactMap { $0.rawValue } ))
        request.delegate = self
        request.start()
    }
    
    
    func purchase(product: Products) {
        guard SKPaymentQueue.canMakePayments(),
              let storeKitProduct = products.first( where: { $0.productIdentifier == product.rawValue } )
        else { return }
        
        let paymentRequest = SKPayment(product: storeKitProduct)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(paymentRequest)
    }
    
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        products = response.products
        
    }
    
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach { transaction in
            switch transaction.transactionState {
            
            case .purchasing:
                break
                
            case .purchased:
                if let product = Products(rawValue: transaction.payment.productIdentifier) {
                    
                }
                
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
                
            case .failed:
                break
                
            case .restored:
                break
                
            case .deferred:
                break
                
            @unknown default:
                break
            }
        }
    }
}
