//
//  TemplatesViewModelProtocol.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 12.05.2021.
//

import Foundation

protocol TemplatesViewModelProtocol {
    
    associatedtype Data
    
    var dataModel: ((Data) -> ())? { get set }
    
    func getDataForContent() -> ()
    
}
