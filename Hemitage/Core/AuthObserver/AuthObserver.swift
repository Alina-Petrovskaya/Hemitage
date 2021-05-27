//
//  AuthObserver.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 30.04.2021.
//

import UIKit

@objc protocol AuthObserver {
    @objc dynamic var kvoResultOfLogin: NSKeyValueObservation? { get set }
    @objc dynamic var kvoErrorMessage: NSKeyValueObservation? { get set }
}

extension AuthObserver where Self: UIViewController {
    
    func observeAuth<T: NSObject & AuthProtocol>(viewModel: T?, _ isNeedToShowSuccessAlert: Bool) {
        kvoResultOfLogin = viewModel?.observe(\.sucssesResult, options: .new, changeHandler: { [weak self] _, result in
            guard let loginResult = result.newValue, loginResult != nil  else { return }
            
            if isNeedToShowSuccessAlert {
                self?.showNotificationAlert(with: loginResult!) {
                    self?.navigationController?.popToRootViewController(animated: true)
                }
                
            } else {
                self?.navigationController?.popToRootViewController(animated: true)
            }
            
        })
        
        kvoErrorMessage = viewModel?.observe(\.errorMessage, options: .new, changeHandler: { [weak self] _, error in
            guard let errorMessage = error.newValue,
                  let message = errorMessage else { return }
            
            self?.showErrorAlert(with: message)
        })
    }
}
