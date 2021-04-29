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
        var currentHeightOfKeyBoard: CGFloat = 0
        keyBoardManager.keyboardStateChanged = { [weak self] keyboardHeight in
            
            print(keyboardHeight)
            
            if keyboardHeight != 0, currentHeightOfKeyBoard == 0 {
                self?.keyBoardCallBack?(keyboardHeight)
                currentHeightOfKeyBoard = keyboardHeight
                
            } else if keyboardHeight == 0, currentHeightOfKeyBoard != 0 {
                self?.keyBoardCallBack?(keyboardHeight)
                currentHeightOfKeyBoard = 0
            }
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
        }
        
        completion(.failure(FirebaseError.unableToRegistrateWithFields))
    }
}
