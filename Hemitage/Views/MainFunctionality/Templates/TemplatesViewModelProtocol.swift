//
//  TemplatesViewModelProtocol.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 12.05.2021.
//

import Foundation

protocol TemplatesViewModelProtocol {
    
    associatedtype Model
    
    var dataModel: ((Model) -> ())? { get set }
    
    func getDataForContent() -> ()
    
}
