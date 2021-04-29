//
//  LoginViewModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 28.04.2021.
//

import Foundation

@objc protocol LoginViewModelProtocol: AnyObject {
    @objc var loginResult: Bool { get }
    @objc var errorMessage: String? { get }
    @objc var keyboardHeight: Float { get }
    @objc func login(email: String?, password: String?, autorizationType: AuthorizationType)
}

class LoginViewModel: NSObject, LoginViewModelProtocol {
    
    @objc dynamic private(set) var loginResult: Bool = false
    @objc dynamic private(set) var errorMessage: String?
    @objc dynamic private(set) var keyboardHeight: Float = 0
    private var autorizationQualifier = AuthorizationTypeQualifier()
    private let keyBoardManager = KeyboardManager()
    
    override init() {
        super.init()
        keyBoardManager.keyboardStateChanged = { [weak self] height in
            self?.keyboardHeight = Float(height)
        }
    }
    
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
