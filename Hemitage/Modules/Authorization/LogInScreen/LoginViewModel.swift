//
//  LoginViewModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 28.04.2021.
//

import Foundation
class LoginViewModel: NSObject, AuthProtocol, KeyboardManagerPorotocol {
    
    @objc dynamic private(set) var sucssesResult: String?
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
                sucssesResult = "User successfully authorized"
                
            case .failed(let error):
                errorMessage = error
            }
        }
    }
    
    
    func login(email: String?, password: String?, autorizationType: AuthorizationType) {
        autorizationQualifier.login(email: email, password: password, loginType: autorizationType)
        
        autorizationQualifier.callBack = { [weak self] authStatus in
            self?.loginStatus = authStatus
        }
    }
    
    
}
