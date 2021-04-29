//
//  EmailFireBaseLogInManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 28.04.2021.
//

import Foundation
import FirebaseAuth


class EmailFireBaseLogInManager: LoginManagerProtocol {
    let email: String
    let password: String
    
    init(email: String, password: String) {
        self.email    = email
        self.password = password
    }
    
    
    func logIn(completion: @escaping (Result<Bool, Error>) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { dataResult, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            completion(.success(true))
        }
    }
}
