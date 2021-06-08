//
//  GroupScreenViewModelDelegate.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 07.06.2021.
//

import Foundation

protocol GroupScreenViewModelDelegate {
    func itemsInserted<T: ViewModelConfigurator>(items: [T], section: GroupScreenTypeOfContent)
    func itemsReloaded<T: ViewModelConfigurator>(newData: T, section: GroupScreenTypeOfContent, index: Int)
    func itemsDeleted<T: ViewModelConfigurator>(items: [T], section: GroupScreenTypeOfContent)
}
