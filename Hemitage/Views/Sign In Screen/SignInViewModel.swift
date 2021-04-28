//
//  SignInViewModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 28.04.2021.
//

import Foundation

class SignInViewModel {
    let email: String?
    let password: String?
    let name: String?
    
    
    init(email: String?, password: String?, name: String?) {
        self.email    = email
        self.password = password
        self.name     = name
        
    }
    
    
    func signIn(completion: @escaping (Result<Bool,Error>) -> ()) {
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
