//
//  SignInViewModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 28.04.2021.
//

import UIKit

class SignInViewModel {
    
    var keyBoardCallBack: ((CGFloat) -> ())?
    private let keyBoardManager = KeyboardManager()
    
    init() {
        keyBoardManager.keyboardStateChanged = { [weak self] keyboardHeight in
            self?.keyBoardCallBack?(keyboardHeight)
        }
    }

    func signIn(email: String?,
                password: String?,
                name: String?,
                completion: @escaping (Result<Bool,Error>) -> ()) {
        
        let validation = Validation()
        
        if validation.validateEmail(email),
           validation.validateName(name),
           validation.validatePassword(password) {
            
           let manager = SignInManager(email: email!, password: password!, name: name!)
            manager.register { completion($0) }
            
        } else {
            completion(.failure(FirebaseError.unableToRegistrateWithFields))
        }
    }
}
