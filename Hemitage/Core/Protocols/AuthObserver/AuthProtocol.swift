//
//  AuthProtocol.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 29.04.2021.
//

import Foundation

@objc protocol AuthProtocol: ResultProtocol {
    
    func login(email: String?, password: String?, autorizationType: AuthorizationType)
}
