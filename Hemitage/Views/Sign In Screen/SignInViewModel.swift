//
//  SignInViewModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 28.04.2021.
//

import Foundation

class SignInViewModel {

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
