//
//  PasscodeManagerProtocol.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 25.05.2021.
//

import Foundation

@objc protocol PasscodeManagerProtocol {
    @objc dynamic var recoveryResult: String? { get }
    @objc dynamic var errorMessage: String? { get }
}
