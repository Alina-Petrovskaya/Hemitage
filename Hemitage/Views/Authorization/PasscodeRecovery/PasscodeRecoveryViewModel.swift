//
//  PasscodeRecoveryViewModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 25.05.2021.
//

import Foundation

protocol PasscodeRecoveryViewModelProtocol {
    func getNewPassword(for email: String?) -> ()
}


class PasscodeRecoveryViewModel: NSObject, PasscodeRecoveryViewModelProtocol, PasswordManagerProtocol, KeyboardManagerPorotocol {
    
    @objc dynamic var sucssesResult: String?
    @objc dynamic var errorMessage: String?
    @objc dynamic private(set)var keyboardHeight: Float = 0
    
    private let passwordManager: PasswordResetManagerProtocol = PasswordResetManager()
    private let keyBoardManager = KeyboardManager()
    
    
    override init() {
        super.init()
        
        keyBoardManager.keyboardStateChanged = { [weak self] height in
            self?.keyboardHeight = Float(height)
        }
    }
    
    
    func getNewPassword(for email: String?) {
        guard let safeEmail = email else { return }
        
        passwordManager.resetPassword(for: safeEmail) { [weak self] result in
            switch result {
            
            case .success(let message):
                self?.sucssesResult = message
                
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
        }
    }
    
    
}
