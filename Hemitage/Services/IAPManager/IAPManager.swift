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
    func purchase(product: Products, completion: @escaping ((Int) -> ()) )
    
}

class IAPManager: NSObject, IAPManagerProtocol, SKProductsRequestDelegate, SKPaymentTransactionObserver {
 
    static let shared: IAPManagerProtocol = IAPManager()
    
    private var products: [SKProduct] = []
    private var copmpletion: ((Int) -> ())?
    
    private override init() {
        super.init()
    }
    
    
    
    func fetchProducts() {
        let request = SKProductsRequest(productIdentifiers: Set(Products.allCases.compactMap{ $0.rawValue }))
        request.delegate = self
        request.start()
    }
    
    
    func purchase(product: Products, completion: @escaping ((Int) -> ())) {
        guard SKPaymentQueue.canMakePayments(),
              let storeKitProduct = products.first( where: { $0.productIdentifier == product.rawValue } )
        else {
            return
        }
        
        self.copmpletion   = completion
        
        let paymentRequest = SKPayment(product: storeKitProduct)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(paymentRequest)
    }
    
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("All products \(response.products.count)")
        products = response.products
    }
    
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach { transaction in
            switch transaction.transactionState {
            
            case .purchasing:
                break
                
            case .purchased:
                print("Payed")
                SKPaymentQueue.default().remove(self)
                SKPaymentQueue.default().finishTransaction(transaction)
                
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
