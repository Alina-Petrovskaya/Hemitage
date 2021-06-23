//
//  IAPManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 23.06.2021.
//

import Foundation
import StoreKit

class IAPManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    enum Product: String, CaseIterable {
        case offlineMonthMode = "hemitage_399_month_subscribe"
    }

    static let shared = IAPManager()
    
    var products: [SKProduct] = []
    
    
    func fetchProducts() {
        let request = SKProductsRequest(productIdentifiers: Set(Product.allCases.compactMap{ $0.rawValue }))
        request.delegate = self
        request.start()
    }
    
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print(response.products.count)
        products = response.products
    }
    
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
    }
}
