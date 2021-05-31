//
//  NewPasscodeViewModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 26.05.2021.
//

import Foundation

protocol NewPasscodeViewModelProtocol {
    func setNewPassword(firstPassword: String?, secondPassword: String?)
}


class NewPasscodeViewModel: NSObject, AuthProtocol, KeyboardManagerPorotocol, NewPasscodeViewModelProtocol {
    
    @objc dynamic private(set) var sucssesResult: String?
    @objc dynamic private(set) var errorMessage: String?
    @objc dynamic private(set) var keyboardHeight: Float = 0
    
    private var passwordManager: PasswordResetManagerProtocol = PasswordResetManager()
    private var authManager     = AuthorizationTypeQualifier()
    private var keyBoardManager = KeyboardManager()
    private let validator       = Validation()
    private var obbCode: String
    private var email: String
    
    
    init(email: String, obbCode: String ) {
        
        self.obbCode = obbCode
        self.email   = email
        
        super.init()
        
        keyBoardManager.keyboardStateChanged = { [weak self] height in
            self?.keyboardHeight = Float(height)
        }
    }
    
    
    func setNewPassword(firstPassword: String?, secondPassword: String?) {
        guard firstPassword == secondPassword else {
            errorMessage = "Passwords must match"
            return
        }
        
        guard validator.validatePassword(firstPassword), validator.validatePassword(secondPassword) else {
            errorMessage = "Password too short"
            return
        }
        
        passwordProcessing(secondPassword!)
    }
    
    
    private func passwordProcessing(_ password: String) {
        passwordManager.setNewPasswordWithObbCode(password, oobCode: obbCode) { [weak self] result in
            
            switch result {
            
            case .success(_):
                self?.login(email: self?.email, password: password, autorizationType: .email)
                
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
        }
    }
    
    
    func login(email: String?, password: String?, autorizationType: AuthorizationType) {
        authManager.callBack = { [weak self] loginStatus in
            switch loginStatus {
            
            case .notActive:
                break
                
            case .success:
                self?.sucssesResult = "Password successfully changed"
                
            case .failed(let error):
                self?.errorMessage = error
                print(error)
            }
        }
        
        authManager.login(email: email, password: password, loginType: autorizationType)
    }
    
}
