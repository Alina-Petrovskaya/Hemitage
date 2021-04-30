//
//  EmailFireBaseLogInManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 28.04.2021.
//

import Foundation
import FirebaseAuth


class EmailFireBaseLogInManager: LoginManagerProtocol {
    var delegate: AuthResultDelegate?
    
    let email: String
    let password: String
    
    init(email: String, password: String) {
        self.email    = email
        self.password = password
    }
    
    
    func logIn() -> () {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] dataResult, error in
            guard error == nil else {
                self?.delegate?.getAuthResult(result: .failure(error!))
                return
            }
            DispatchQueue.main.async {
                self?.delegate?.getAuthResult(result: .success(true))
            }
        }
    }
}
