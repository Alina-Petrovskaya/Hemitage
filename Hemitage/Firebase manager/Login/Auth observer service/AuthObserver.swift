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
    
    func observeAuth<T: NSObject & LoginViewModelProtocol>(viewModel: T) {
        kvoResultOfLogin = viewModel.observe(\.loginResult, options: .new, changeHandler: { _, result in
            guard result.newValue != nil else { return }
            print("success loged in with result")
        })
        
        kvoErrorMessage = viewModel.observe(\.errorMessage, options: .new, changeHandler: { [weak self] _, error in
            guard let errorMessage = error.newValue,
                  let message = errorMessage else { return }
            
            self?.showErrorAlert(with: message)
        })
    }
}
