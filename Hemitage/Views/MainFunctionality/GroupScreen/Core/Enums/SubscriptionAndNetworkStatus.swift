//
//  SubscriptionAndNetworkStatus.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 14.06.2021.
//

import Foundation

enum SubscriptionAndNetworkStatus {
    case unowned
    case noNetworkNoSubscription
    case noNetworkSubscription
    case standart
    case gold
    
    func isNeedToLoadDataFromFareStore() -> Bool {
        switch self {
        case .unowned, .noNetworkNoSubscription, .noNetworkSubscription:
            return false
            
        case .standart, .gold:
            return true
        }
    }
    
    func isCanPlayMusic() -> Bool {
        switch self {
        case .unowned, .noNetworkNoSubscription:
            return false
            
        case .standart, .gold, .noNetworkSubscription:
            return true
        }
    }
}
