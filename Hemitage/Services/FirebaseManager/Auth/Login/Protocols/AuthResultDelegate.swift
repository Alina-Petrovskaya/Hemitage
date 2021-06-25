//
//  AuthResultDelegate.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 30.04.2021.
//

import Foundation

protocol AuthResultDelegate {
    
    func getAuthResult(result: Result<Bool, Error>)
    func logOut()
}
