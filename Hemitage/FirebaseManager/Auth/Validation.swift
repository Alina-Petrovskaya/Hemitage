//
//  Validation.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 28.04.2021.
//

import Foundation

class Validation {
    func validatePassword(_ password: String?) -> Bool {
        guard let password = password,
              !password.isEmpty,
              password.count >= 6
              else { return false }
        
        return true
    }
    
    func validateEmail(_ email: String?) -> Bool {
        guard let email = email,
              !email.isEmpty
              else { return false }
        
        return true
    }
    
    
    func validateName(_ name: String?) -> Bool {
        guard let name = name,
              !name.isEmpty
              else { return false }
        
        return true
    }
}
