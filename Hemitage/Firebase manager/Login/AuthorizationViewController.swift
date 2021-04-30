//
//  AuthorizationViewController.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 29.04.2021.
//

import UIKit

class AuthorizationViewController: UIViewController {
    
    @objc dynamic var kvoResultOfLogin: NSKeyValueObservation?
    @objc dynamic var kvoErrorMessage: NSKeyValueObservation?
    @objc dynamic var kvoKeyboardHeight: NSKeyValueObservation?
    let rootController = AppDelegate.shared.rootViewController
    var keyboardHeight: CGFloat?
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        kvoResultOfLogin?.invalidate()
        kvoErrorMessage?.invalidate()
        kvoKeyboardHeight?.invalidate()
    }

    func observe<T: NSObject & LoginViewModelProtocol>(viewModel: T) {
        kvoResultOfLogin = viewModel.observe(\.loginResult, options: .new, changeHandler: { _, result in
            guard result.newValue != nil else { return }
            print("success loged in with result")
        })
        
        kvoErrorMessage = viewModel.observe(\.errorMessage, options: .new, changeHandler: { [weak self] _, error in
            guard let errorMessage = error.newValue,
                  let message = errorMessage else { return }
            
            self?.showErrorAlert(with: message)
        })
        
        kvoKeyboardHeight = viewModel.observe(\.keyboardHeight, options: .new, changeHandler: { [weak self] _, heightInformation in
            guard let height = heightInformation.newValue else { return }
            self?.keyboardHeight = CGFloat(height)
        })
    }
}
