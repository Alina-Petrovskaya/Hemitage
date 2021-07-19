//
//  PasswordResetManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 25.05.2021.
//

import Foundation
import FirebaseAuth


protocol PasswordResetManagerProtocol {
    func resetPassword(for userEmail: String, completion: @escaping (Result<String, Error>) -> ())
    func setNewPasswordWithObbCode(_ password: String, oobCode: String, completion: @escaping (Result<String, Error>) -> ())
    func updatePasswordToCurrentUser(with password: String, completion: @escaping (Result<String, Error>) -> ())
}


class PasswordResetManager: PasswordResetManagerProtocol {
    
    func resetPassword(for userEmail: String, completion: @escaping (Result<String, Error>) -> ()) {
        
        Auth.auth().fetchSignInMethods(forEmail: userEmail) { providers, error in

            if let error = error {
                completion(.failure(error))
                
            } else if let safeproviders = providers, safeproviders.contains(where: { $0 == "password" }) {
                
                Auth.auth().sendPasswordReset(withEmail: userEmail) { error in
                    if let error = error {
                        completion(.failure(error))
                        
                    } else {
                        completion(.success("Password recovery link have been sent to your email \(userEmail). Please check it"))
                    }
                }
                
            } else {
                completion(.failure(FirebaseError.differentSignInCredential))
            }
        }
    }
    

    func updatePasswordToCurrentUser(with password: String, completion: @escaping (Result<String, Error>) -> () ) {
        Auth.auth().currentUser?.updatePassword(to: password) { error in
            
        }
    }
    
    
    func setNewPasswordWithObbCode(_ password: String, oobCode: String, completion: @escaping (Result<String, Error>) -> ()) {
        
        Auth.auth().confirmPasswordReset(withCode: oobCode, newPassword: password) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success("Password has been changed"))
            }
        }
    }
    
    
    
}
