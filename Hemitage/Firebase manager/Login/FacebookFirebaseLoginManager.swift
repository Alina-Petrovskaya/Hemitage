//
//  FacebookFirebaseLoginManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 29.04.2021.
//

import UIKit
import FBSDKLoginKit


class FacebookFirebaseLoginManager: LoginManagerProtocol {
    
    let loginButton = FBLoginButton()
    
    func logIn(completion: @escaping (Result<Bool, Error>) -> ()) {
        
        if AccessToken.current != nil {
            LoginManager().logOut()
                return
            }
        
        
    }
}

