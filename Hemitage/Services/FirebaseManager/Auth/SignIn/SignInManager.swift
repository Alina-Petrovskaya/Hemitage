//
//  SignInManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 28.04.2021.
//

import Foundation
import FirebaseAuth

class SignInManager {

    func register(data: (email: String, password: String, name: String),
                  completion: @escaping (Result<Bool, Error>) -> ()) {
        
        Auth.auth().createUser(withEmail: data.email, password: data.password)  { _, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = data.name
            
            changeRequest?.commitChanges() { error in
                if error == nil {
                    
                    Auth.auth().signIn(withEmail: data.email, password: data.password) { AuthResult, error in
                        if error == nil {
                            completion(.success(true))
                        } else {
                            completion(.failure(error!))
                        }
                    }
                }
            }
        }
    }
    
}
