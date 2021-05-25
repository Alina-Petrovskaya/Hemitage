//
//  LoginManagerProtocol.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 30.04.2021.
//

import Foundation

protocol LoginManagerProtocol {
    
    func logIn() -> ()
    
    var delegate: AuthResultDelegate? {get set}
}
