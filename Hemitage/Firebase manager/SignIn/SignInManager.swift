//
//  SignInManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 28.04.2021.
//

import Foundation
import FirebaseAuth

class SignInManager {
    
    let email: String
    let password: String
    let name: String
    
    init(email: String, password: String, name: String) {
        self.email    = email
        self.password = password
        self.name     = name
    }
    
    func register(completion: @escaping (Result<Bool, Error>) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            completion(.success(true))
        }
    }
    
    private func savePrivateDataIntoIntoRealtimeDataBase() {
        
    }
}
