//
//  WelcomeViewModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 29.04.2021.
//

import Foundation

class WelcomeViewModel: NSObject, LoginViewModelProtocol {
    
    @objc dynamic private(set) var loginResult: Bool = false
    @objc dynamic private(set) var errorMessage: String?
    @objc dynamic private(set) var keyboardHeight: Float = 0
    private var autorizationQualifier = AuthorizationTypeQualifier()
    private let keyBoardManager = KeyboardManager()
    
    private var loginStatus: LoginStatus = .notActive {
        didSet {
            switch loginStatus {
            case .notActive:
                break
            case .success:
                loginResult = true
                
            case .failed(let error):
                errorMessage = error
            }
        }
    }
    
    
    func login(email: String?, password: String?, autorizationType: AuthorizationType) {
        autorizationQualifier.login(email: email, password: password, loginType: autorizationType) { [weak self] status in
            self?.loginStatus = status
        }
    }
}
