//
//  LoginViewModelProtocol.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 29.04.2021.
//

import Foundation

@objc protocol LoginViewModelProtocol: AnyObject {
    
    @objc dynamic var loginResult: Bool { get }
    @objc dynamic var errorMessage: String? { get }
    
    func login(email: String?, password: String?, autorizationType: AuthorizationType)
}
