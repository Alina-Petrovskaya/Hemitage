//
//  AuthResultDelegateProtocol.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 30.04.2021.
//

import Foundation

protocol AuthResultDelegateProtocol {
    func getAuthResult(result: Result<Bool, Error>)
}
