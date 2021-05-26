//
//  PasswordRecoveryObserver.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 25.05.2021.
//

import UIKit

@objc protocol PasswordRecoveryObserver {
    
    @objc dynamic var kvoSuccesResult: NSKeyValueObservation? { get set }
    @objc dynamic var kvoErrorMessage: NSKeyValueObservation? { get set }
}


extension PasswordRecoveryObserver where Self: UIViewController {
    
    func observePasscodedManager<T: NSObject & PasswordManagerProtocol>(viewModel: T?, isNeedToHideSelf: Bool) {
       
        kvoSuccesResult = viewModel?.observe(\.sucssesResult, options: .new) { [weak self] _, result in
            guard let successText = result.newValue,
                  let safeSuccessText = successText else { return }
            
            self?.showNotificationAlert(with: safeSuccessText, isNeedToHideSelf: isNeedToHideSelf)
        }
        
        
        kvoErrorMessage = viewModel?.observe(\.errorMessage, options: .new) { [weak self] _, error in
            guard let errorMessage = error.newValue,
                  let safeErrorMessage = errorMessage else { return }
            
            self?.showErrorAlert(with: safeErrorMessage)
        }
    }
}
