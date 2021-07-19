//
//  FacebookFirebaseLoginManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 29.04.2021.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth


class FacebookFirebaseLoginManager: LoginManagerProtocol {
  
    var delegate: AuthResultDelegate?
    
    func logIn() -> () {
        
        if AccessToken.current != nil {
            LoginManager().logOut()
        }
        
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["email", "public_profile"], from: nil) { [weak self] result, error in
            guard error == nil else {
                self?.delegate?.getAuthResult(result: .failure(error!))
                return
            }
            
            guard let token = result?.token?.tokenString else { return }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: token)
            Auth.auth().signIn(with: credential) { result, error in
                guard error == nil else {
                    self?.delegate?.getAuthResult(result: .failure(error!))
                    return
                }
                
                self?.delegate?.getAuthResult(result: .success(true))
            }
        }
    }
    
    
    func logOut() {
        LoginManager().logOut()
    }
}

