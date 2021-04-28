//
//  LoginViewModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 28.04.2021.
//

import Foundation

class LoginViewModel {
    var email: String?
    var password: String?
    
    
    init(email: String?, password: String?) {
        self.email    = email
        self.password = password
//
//        var loginManager: LoginManager = EmailFireBaseLogInManager(email: email, password: password)
//        _ = loginManager.logIn(completion: { result in
//            switch result
//        })
    }
}
