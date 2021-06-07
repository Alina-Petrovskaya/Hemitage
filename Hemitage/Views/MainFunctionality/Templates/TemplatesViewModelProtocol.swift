//
//  TemplatesViewModelProtocol.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 12.05.2021.
//

import Foundation

protocol TemplatesViewModelProtocol {
    associatedtype DataType
    
    func getDataForContent() -> DataType
    func updateData(with data: DataType)
    
}
