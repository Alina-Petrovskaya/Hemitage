//
//  PasswordManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 25.05.2021.
//

import Foundation
import FirebaseAuth

class PasswordManager {
    
    static var shared = PasswordManager()
    var chatchValidOobCode: ((String) -> ())?

    var obbCode: String? = nil {
        didSet {
            guard let safeCode = obbCode else { return }
            checkCode(with: safeCode)
        }
    }
    
    private init() {
        
    }
    
    func resetPassword(for userEmail: String, completion: @escaping (Result<String, Error>) -> ()) {
        Auth.auth().sendPasswordReset(withEmail: userEmail) { error in
            if let error = error {
                completion(.failure(error))
                
            } else {
                completion(.success("Password recovery link have been sent to your email \(userEmail). Please check it"))
            }
        }
    }
    
    
    private func checkCode(with code: String) {
        Auth.auth().verifyPasswordResetCode(code) { email, error in
            if let error = error {
                print(error.localizedDescription)
                
                //Nothing to do
                
            
            } else if email != nil {
                //send oobCode and present screren "New passcode"
                print(email!)
                print(code)
            }
        }
    }
    
    
    func setNewPassword(password: String, oobCode: String) {
        Auth.auth().confirmPasswordReset(withCode: oobCode, newPassword: password) { error in
            
        }
    }
}
