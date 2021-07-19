//
//  SignInViewModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 28.04.2021.
//

import UIKit

protocol SignInViewModelProtocol {
    var keyBoardCallBack: ((CGFloat) -> ())? { get set }
    func signIn(email: String?, password: String?, name: String?, completion: @escaping (Result<Bool, Error>) -> ())
}

class SignInViewModel: SignInViewModelProtocol {
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
            
           let manager = SignInManager()
            manager.register(data: (email: email!, password: password!, name: name!)) { completion($0) }
            
        } else {
            completion(.failure(FirebaseError.unableToRegistrateWithFields))
        }
    }
}
