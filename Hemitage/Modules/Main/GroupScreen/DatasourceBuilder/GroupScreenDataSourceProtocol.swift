//
//  GroupScreenDataSourceProtocol.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 02.06.2021.
//

import Foundation

protocol GroupScreenDataSourceProtocol {
    
    func getDelegateObject<T>() -> T?
    
    func reloadData<T: GroupScreenViewModelProtocol>(with viewModel: T)
    func insertItems<T: ViewModelConfigurator>(items: [T])
    func reloadItems<T: ViewModelConfigurator>(data: T, with index: Int)
    func deleteItems<T: ViewModelConfigurator>(items: [T])
}
