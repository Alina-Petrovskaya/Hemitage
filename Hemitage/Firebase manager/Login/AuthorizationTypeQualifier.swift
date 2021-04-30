//
//  AuthorizationTypeQualifier.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 28.04.2021.
//

import Foundation


protocol LoginManagerProtocol {
    func logIn(completion: @escaping (Result<Bool, Error>) -> ())
}

class AuthorizationTypeQualifier {
    let validation = Validation()
    
    func login(email: String? = nil, password: String? = nil, loginType: AuthorizationType, completion: @escaping (LoginStatus) -> ()) {
        var loginManager: LoginManagerProtocol? = nil
        
        switch loginType {
        case .facebook:
            loginManager = FacebookFirebaseLoginManager()
            
        case .email:
            guard validateData(email, password) else {
                completion(.failed("Something wrong with filled fields"))
                return
            }
            loginManager = EmailFireBaseLogInManager(email: email!, password: password!)
            
        case .apple:
            loginManager = AppleFirebaseLoginManager()
        }
        
        
        loginManager?.logIn(completion: { result in
            switch result {
            case .success(_):
                completion(.success)
                
            case .failure(let error):
                completion(.failed(error.localizedDescription))
            }
        })
    }
    
    private func validateData(_ email: String?, _ password: String?) -> Bool {
        if validation.validateEmail(email), validation.validatePassword(password) {
            return true
        }
        
        return false
    }
}
