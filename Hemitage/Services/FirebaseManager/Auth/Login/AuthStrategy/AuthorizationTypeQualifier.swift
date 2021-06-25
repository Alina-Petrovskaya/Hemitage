//
//  AuthorizationTypeQualifier.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 28.04.2021.
//

import Foundation

class AuthorizationTypeQualifier: AuthResultDelegate {
    
    let validation = Validation()
    var callBack: ((LoginStatus) -> ())?
    var loginManager: LoginManagerProtocol?
    
    func login(email: String? = nil, password: String? = nil, loginType: AuthorizationType) {
        switch loginType {
        case .facebook:
            loginManager = FacebookFirebaseLoginManager()
            
        case .email:
            guard validateData(email, password) else {
                callBack?(.failed("Something wrong with filled fields"))
                return
            }
            loginManager = EmailFireBaseLogInManager(email: email!, password: password!)
            
            
        case .apple:
            loginManager = AppleFirebaseLoginManager()
        }
        loginManager?.delegate = self
        loginManager?.logIn()
    }
    
    
    func logOut() {
        FacebookFirebaseLoginManager().logOut()
        EmailFireBaseLogInManager(email: "", password: "").logOut()
        AppleFirebaseLoginManager().logOut()
    }
    
    
    func getAuthResult(result: Result<Bool, Error>) {
        switch result {
        case .success(_):
            callBack?(.success)
            
        case .failure(let error):
            callBack?(.failed(error.localizedDescription))
        }
    }
    
    private func validateData(_ email: String?, _ password: String?) -> Bool {
        if validation.validateEmail(email), validation.validatePassword(password) {
            return true
        }
        
        return false
    }
}
