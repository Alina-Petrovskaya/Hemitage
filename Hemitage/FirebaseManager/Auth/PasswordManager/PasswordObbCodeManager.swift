//
//  PasswordObbCodeManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 26.05.2021.
//

import Foundation
import FirebaseAuth


protocol PasswordObbCode {
    
    static var shared: PasswordObbCode { get }
    var callback: ((Result<(obbcode: String, email: String), Error>) -> ())? { get set }
    
    func checkObbCode(with code: String)
}


class PasswordObbCodeManager: NSObject, PasswordObbCode {
    
    static var shared: PasswordObbCode = PasswordObbCodeManager()
    var callback: ((Result<(obbcode: String, email: String), Error>) -> ())?
    
    
    private override init() {  }
    
    
    func checkObbCode(with code: String) {
        Auth.auth().verifyPasswordResetCode(code) { [weak self] email, error in
            if let error = error {
                self?.callback?(.failure(error))

            } else if let safeEmail = email {
                self?.callback?(.success((obbcode: code, email: safeEmail)))
            }
        }
    }
}
