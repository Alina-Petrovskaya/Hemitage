//
//  NewPasscodeViewModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 26.05.2021.
//

import Foundation

protocol NewPasscodeViewModelProtocol {
    func setNewPassword(firstPassword: String?, secondPassword: String?, email: String?, obbCode: String?)
}


class NewPasscodeViewModel: NSObject, LoginProtocol, KeyboardManagerPorotocol, NewPasscodeViewModelProtocol {
    
    @objc dynamic private(set) var sucssesResult: String?
    @objc dynamic private(set) var errorMessage: String?
    @objc dynamic private(set) var keyboardHeight: Float = 0
    
    private var passwordManager: PasswordResetManagerProtocol = PasswordResetManager()
    private var authManager     = AuthorizationTypeQualifier()
    private var keyBoardManager = KeyboardManager()
    private let validator       = Validation()
    
    
    override init() {
        super.init()
        
        keyBoardManager.keyboardStateChanged = { [weak self] height in
            self?.keyboardHeight = Float(height)
        }
    }
    
    
    func setNewPassword(firstPassword: String?, secondPassword: String?, email: String?, obbCode: String?) {
        guard firstPassword == secondPassword else {
            errorMessage = "Passwords must match"
            return
        }
        
        guard validator.validatePassword(firstPassword), validator.validatePassword(secondPassword) else {
            errorMessage = "Password too short"
            return
        }
        
        
        if let safeObbCode = obbCode, let safeEmail = email {
            passwordProcessing(safeObbCode, secondPassword!, for: safeEmail)
            
        } else {
            errorMessage = "It seems like something is wrong. Contact the app developer"
        }
        
    }
    
    
    private func passwordProcessing(_ obbCode: String, _ password: String, for email: String) {
        passwordManager.setNewPasswordWithObbCode(password, oobCode: obbCode) { [weak self] result in
            
            switch result {
            
            case .success(_):
                self?.login(email: email, password: password, autorizationType: .email)
                
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
            }
        }
    }
    
}
