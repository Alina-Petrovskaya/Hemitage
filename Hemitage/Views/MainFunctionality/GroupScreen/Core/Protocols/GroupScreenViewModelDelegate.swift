//
//  GroupScreenViewModelDelegate.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 07.06.2021.
//

import Foundation

protocol GroupScreenViewModelDelegate {
    
    func updateData<T: ViewModelConfigurator>(items: [T], section: GroupScreenTypeOfContent, typeOfChange: TypeOfChangeDocument, index: Int?)
    func reloadData(section: GroupScreenTypeOfContent)
    
}
