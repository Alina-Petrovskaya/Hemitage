//
//  Decoder.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 31.05.2021.
//

import Foundation

protocol Decoder {
    associatedtype ReturnType: Codable
    
    func decode(from data: Data?) -> ReturnType?
}
