//
//  AuthorizationTypeQualifier.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 28.04.2021.
//

import Foundation


protocol LoginManager {
    func logIn(completion: @escaping (Result<Bool, Error>) -> ())
}

class AuthorizationTypeQualifier {
    
}
