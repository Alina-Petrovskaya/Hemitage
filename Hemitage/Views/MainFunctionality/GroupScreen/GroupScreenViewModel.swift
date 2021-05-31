//
//  GroupScreenViewModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 31.05.2021.
//

import Foundation

class GroupScreenViewModel {
    
    private enum StateOfNavigationBar {
        case small, large, undefined
    }
    
    private var stateOfNavigationBar: StateOfNavigationBar = .undefined
    
    
    
    func heightNavBarHandling(height: Double?, completion: () -> ()) {
        
        guard let safeHeight = height else { return }
        let currentTypeOfNavBar = determinationOfNavBarStatus(with: safeHeight)
        
        switch stateOfNavigationBar {
        
        case .undefined:
            stateOfNavigationBar = currentTypeOfNavBar
        
        default:
            if stateOfNavigationBar != currentTypeOfNavBar {
                completion()
                stateOfNavigationBar = currentTypeOfNavBar
            }
        }
        
    }
    
    
    private func determinationOfNavBarStatus(with height: Double) -> StateOfNavigationBar {
        if height > 44.0 {
            return .large
        } else {
            return .small
        }
    }
    
    
}
