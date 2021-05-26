//
//  PasswordResetObserver.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 25.05.2021.
//

import UIKit

@objc protocol PasswordResetObserver {
    
    @objc dynamic var kvoResult: NSKeyValueObservation? { get set }
    @objc dynamic var kvoErrorMessage: NSKeyValueObservation? { get set }
}


extension PasswordResetObserver where Self: UIViewController {
    
    func observePasscodedManager<T: NSObject & PasscodeManagerProtocol>(viewModel: T?) {
       
        kvoResult = viewModel?.observe(\.recoveryResult, options: .new) { [weak self] _, result in
            guard let successText = result.newValue,
                  let safeSuccessText = successText else { return }
            
            self?.showNotificationAlert(with: safeSuccessText, isNeedToHideSelf: false)
        }
        
        
        kvoErrorMessage = viewModel?.observe(\.errorMessage, options: .new) { [weak self] _, error in
            guard let errorMessage = error.newValue,
                  let safeErrorMessage = errorMessage else { return }
            
            self?.showErrorAlert(with: safeErrorMessage)
        }
    }
}
