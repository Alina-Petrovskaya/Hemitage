//
//  ResultProtocol.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 25.06.2021.
//

import Foundation

@objc protocol ResultProtocol: AnyObject {
    
    @objc dynamic var sucssesResult: String? { get }
    @objc dynamic var errorMessage: String? { get }
    
}


