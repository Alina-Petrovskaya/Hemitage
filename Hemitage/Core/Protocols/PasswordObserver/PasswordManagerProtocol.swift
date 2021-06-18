//
//  PasswordManagerProtocol.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 25.05.2021.
//

import Foundation

@objc protocol PasswordManagerProtocol {
    
    @objc dynamic var sucssesResult: String? { get }
    @objc dynamic var errorMessage: String? { get }
    
}
