//
//  GroupScreenDataSourceProtocol.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 02.06.2021.
//

import Foundation

protocol GroupScreenDataSourceProtocol {
    
    //    var collectionViewDelegate: MainScreenCollectionViewDelegate { get }
    
    associatedtype Data: Hashable
    
    func reloadData<T: GroupScreenViewModelProtocol>(with viewModel: T)
    func insertItems(items: [Data])
    func reloadItems(data: Data, with index: Int)
    func deleteItems(items: [Data])
}
