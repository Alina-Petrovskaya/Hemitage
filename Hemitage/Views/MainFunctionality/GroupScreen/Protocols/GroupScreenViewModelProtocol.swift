//
//  GroupScreenViewModelProtocol.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 07.06.2021.
//

import Foundation

protocol GroupScreenViewModelProtocol {
    var delegate: GroupScreenViewModelDelegate? { get set }
    
    func heightNavBarHandling(height: Double?, completion: () -> ())
    func getDataContent<T: ViewModelConfigurator>(for contentType: GroupScreenTypeOfContent) -> [T]?
}

