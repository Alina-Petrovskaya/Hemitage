//
//  LoginManagerProtocol.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 30.04.2021.
//

import Foundation
import FirebaseAuth

protocol LoginManagerProtocol {
    
    var delegate: AuthResultDelegate? {get set}
    
    func logIn() -> ()
    func logOut()
    
}
