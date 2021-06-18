//
//  SubscriptionAndNetworkStatus.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 14.06.2021.
//

import Foundation

enum SubscriptionAndNetworkStatus {
    case unowned
    case free
    case noNetworkNoSubscription
    case noNetworkSubscriptionStandart
    case noNetworkSubscriptionGold
    case standart
    case gold
    
    func isCanPlayMusic() -> Bool {
        switch self {
        case .unowned, .noNetworkNoSubscription:
            return false
            
        case .standart, .gold, .noNetworkSubscriptionStandart, .noNetworkSubscriptionGold, .free:
            return true
        }
    }
    
    func isPremiumContentHidden() -> Bool {
        switch self {
        
        case .gold, .noNetworkSubscriptionGold:
            return false
            
        default:
            return true
        }
    }
    
    
    func isNeedToByeContent() -> Bool {
        switch self {
        case .noNetworkNoSubscription, .unowned:
            return true
            
        default:
            return false
        }
    }
}
