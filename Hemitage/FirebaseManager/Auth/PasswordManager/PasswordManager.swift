//
//  PasswordManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 25.05.2021.
//

import Foundation
import FirebaseAuth
import Firebase

class PasswordManager {
    
    func resetPassword(for userEmail: String, completion: @escaping (Result<String, Error>) -> ()) {
        
        Auth.auth().sendPasswordReset(withEmail: userEmail) { error in
            if let error = error {
                completion(.failure(error))
                
            } else {
                completion(.success("Password recovery instructions have been sent to your email \(userEmail)"))
            }
        }
    }
    
    
    
    func setNewPassword(with password: String) {
        Auth.auth().currentUser?.updatePassword(to: password) { error in
            
        }
    }
}
