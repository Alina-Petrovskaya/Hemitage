//
//  ViewModelConfigurator.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 31.05.2021.
//

import Foundation

protocol ViewModelConfigurator {
    associatedtype DataType
    
    func getData() -> DataType
    func setData(with data: DataType)
    func getID() -> String
}
