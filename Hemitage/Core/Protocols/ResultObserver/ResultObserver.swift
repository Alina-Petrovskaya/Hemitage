//
//  ResultObserver.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 25.06.2021.
//

import UIKit

@objc protocol ResultObserver {
    @objc dynamic var kvoSuccess: NSKeyValueObservation? { get set }
    @objc dynamic var kvoError: NSKeyValueObservation? { get set }
}

extension ResultObserver where Self: UIViewController {
    
    func observeAuth<T: NSObject & ResultProtocol>(viewModel: T?) {
        kvoSuccess = viewModel?.observe(\.sucssesResult, options: .new) { [weak self] _, result in
            guard let loginResult = result.newValue, loginResult != nil
            else { return }
            
            self?.showNotificationAlert(with: loginResult!) {
                self?.navigationController?.popToRootViewController(animated: true)
                
            }
        }
        
        kvoError = viewModel?.observe(\.errorMessage, options: .new) { [weak self] _, error in
            guard let errorMessage = error.newValue,
                  let message = errorMessage else { return }
            
            self?.showErrorAlert(with: message)
        }
    }
    
}
