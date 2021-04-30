//
//  LoginViewModelProtocol.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 29.04.2021.
//

import Foundation

@objc protocol LoginViewModelProtocol: AnyObject {
    @objc var loginResult: Bool { get }
    @objc var errorMessage: String? { get }
    @objc var keyboardHeight: Float { get }
    func login(email: String?, password: String?, autorizationType: AuthorizationType)
}
